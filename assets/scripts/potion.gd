extends Node

@onready var parent : Node2D = get_parent()
@onready var effects : Array = get_children()

var duration : float = 5
var effects_id : Array = [15]

func use() -> void:
	for id in effects_id:
		var link = "res://assets/nodes/potions/" + str(id) + ".tscn"
		var effect = load(link).instantiate()
		if "duration" in effect:
			effect.duration = duration
		get_parent().add_child(effect)
		
	
