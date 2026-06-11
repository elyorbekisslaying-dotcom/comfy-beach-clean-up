extends Node2D
class_name Main

@onready var status_label: Label = $CanvasLayer/Label
var total_trash: int = 0
var cleaned_trash: int = 0
var mistakes: int = 0

func _ready() -> void:
	total_trash = count_trash()
	update_status()

func count_trash() -> int:
	var total: int = 0
	for item_node in get_tree().get_nodes_in_group("beach_item"):
		var item = item_node as BeachItem
		if item and item.item_type == "trash":
			total += 1
	return total

func register_disposal(correct: bool) -> void:
	if correct:
		cleaned_trash += 1
	else:
		mistakes += 1
	update_status()
	if cleaned_trash >= total_trash:
		show_final_message()

func update_status() -> void:
	status_label.text = "Narrator: Clean the beach. Remove everything.\nTrash cleaned: %d / %d\nMistakes: %d" % [cleaned_trash, total_trash, mistakes]

func show_final_message() -> void:
	if mistakes == 0:
		status_label.text = "The beach is healthy. You learned what truly belongs here."
	else:
		status_label.text = "The beach is cleaner, but something feels wrong..."
