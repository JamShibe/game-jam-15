extends Node2D

var player : CharacterBody2D
var type : String

@onready var sprite : AnimatedSprite2D = $box/AnimatedSprite2D

func _ready():
	sprite.play(type)
	
func _process(delta):
	print(type)
	sprite.play(type)
	if player:
		if type == "Throwable":
			if player.throw_cooldown.is_stopped():
				modulate = Color(1,1,1,1)
			else:
				modulate = Color(1,1,1,0.25)
		elif type == "Drinkable":
			if player.drink_cooldown.is_stopped():
				modulate = Color(1,1,1,1)
			else:
				modulate = Color(1,1,1,0.25)
