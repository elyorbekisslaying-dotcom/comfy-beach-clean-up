extends Area2D
class_name Bin

func _enter_tree() -> void:
	add_to_group("bin")

func interact(player: Player) -> void:
	if player.carried_item == null:
		print("Nothing to throw away.")
		return
	var item = player.carried_item
	var correct = item.item_type == "trash"
	if correct:
		print("Trash disposed correctly: %s" % item.item_name)
	else:
		print("Wrong item removed: %s (%s)" % [item.item_name, item.item_type])
	player.carried_item = null
	item.queue_free()
	var main = get_tree().get_current_scene().get_node("Main") as Main
	if main:
		main.register_disposal(correct)
