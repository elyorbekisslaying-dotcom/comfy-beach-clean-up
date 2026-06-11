extends CharacterBody2D
class_name Player

@export var speed: float = 220.0
var carried_item: BeachItem | null = null
const INTERACT_RANGE: float = 48.0

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = int(Input.is_key_pressed(Key.D) or Input.is_key_pressed(Key.Right)) - int(Input.is_key_pressed(Key.A) or Input.is_key_pressed(Key.Left))
	direction.y = int(Input.is_key_pressed(Key.S) or Input.is_key_pressed(Key.Down)) - int(Input.is_key_pressed(Key.W) or Input.is_key_pressed(Key.Up))
	if direction != Vector2.ZERO:
		velocity = direction.normalized() * speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	if Input.is_key_just_pressed(Key.E):
		interact()

func interact() -> void:
	if carried_item:
		var bin = get_nearest_bin()
		if bin:
			bin.interact(self)
			return
		print("Move closer to the bin to throw away the item.")
		return

	var item = get_nearest_item()
	if item:
		pick_up(item)
		return
	print("No item nearby to pick up.")

func get_nearest_item() -> BeachItem | null:
	var nearest: BeachItem | null = null
	var best_dist = INTERACT_RANGE
	for item_node in get_tree().get_nodes_in_group("beach_item"):
		var item = item_node as BeachItem
		if not item:
			continue
		var dist = global_position.distance_to(item.global_position)
		if dist < best_dist:
			best_dist = dist
			nearest = item
	return nearest

func get_nearest_bin() -> Bin | null:
	var nearest: Bin | null = null
	var best_dist = INTERACT_RANGE
	for bin_node in get_tree().get_nodes_in_group("bin"):
		var bin = bin_node as Bin
		if not bin:
			continue
		var dist = global_position.distance_to(bin.global_position)
		if dist < best_dist:
			best_dist = dist
			nearest = bin
	return nearest

func pick_up(item: BeachItem) -> void:
	carried_item = item
	item.pick_up(self)
	print("Picked up: %s" % item.item_name)
