extends Node2D

@export var is_entrance : bool

@onready var blocker : CharacterBody2D = $blocker

var next_room : bool = false

func _ready():
	if !is_entrance:
		blocker.queue_free()
		
		
func _on_body_entered(body):
	if body.name == "player":
		next_room = true
