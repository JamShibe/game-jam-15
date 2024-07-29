extends Node

@onready var parent : Node2D = get_parent()
@onready var effects : Array = get_children()

var duration : float = 5
var effects_id : Array = []
var prepared : bool = false

func use() -> void:
	if !prepared:
		setup()
		prepared = true
	for id in effects_id:
		var link = "res://assets/nodes/potions/" + str(id) + ".tscn"
		var effect = load(link).instantiate()
		if "duration" in effect:
			effect.duration = duration
		get_parent().add_child(effect)
		
	
func setup():
	var player = get_parent()
	var potions = player.potions_in_use
	print(player.potions_in_use)
	for potion in potions:
		var link = "res://assets/nodes/potions/" + str(potion) + ".tscn"
		var pot = load(link).instantiate()
		if pot.type == "[Drinkable]":
			effects_id.append(potion)
