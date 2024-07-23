extends Node2D

@export var exit : Area2D

var next_room : bool = false

func _process(delta):
	if exit.next_room:
		next_room = exit.next_room
			
