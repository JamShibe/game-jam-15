extends Node2D

@export var magic_circle : Node2D

@onready var potion : AnimatedSprite2D = $Outline
@onready var contents : AnimatedSprite2D = $Outline/Contents

var list_of_none_potions = [0,1,2,4,8,16,32]

func _process(delta):
	if "potion_id" in magic_circle:
		if magic_circle.potion_id in list_of_none_potions:
			potion.visible = false
		else:
			potion.visible = true
		
