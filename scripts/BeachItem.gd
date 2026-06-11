extends Area2D
class_name BeachItem

@export var item_name: String = "Item"
@export var item_type: StringName = "trash"

var is_carried: bool = false
var carrier: Node2D = null
var carry_offset: Vector2 = Vector2(0, -32)

func _ready() -> void:
	add_to_group("beach_item")

func _process(_delta: float) -> void:
	if is_carried and carrier != null:
		global_position = carrier.global_position + carry_offset

func pick_up(new_carrier: Node2D) -> void:
	is_carried = true
	carrier = new_carrier

func drop() -> void:
	is_carried = false
	carrier = null
