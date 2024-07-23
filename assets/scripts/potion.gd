extends Node

@onready var parent : Node2D = get_parent()
@onready var effects : Array = get_children()

var duration : float = 15

func use() -> void:
	for child in effects:
		if child.has_method("apply_effect"):
			child.apply_effect(parent)
		await get_tree().create_timer(duration).timeout
		parent.reset()
