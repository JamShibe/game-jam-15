extends Node

@onready var parent : Node2D = get_parent()
@onready var effects : Array = get_children()

func use() -> void:
	for child in effects:
		if child.has_method("apply_effect"):
			child.apply_effect(parent)
		
