extends Node

#Allows speed to be set in the inspector
@export var speed : float

@onready var parent = get_parent()

func _physics_process(delta):
	parent.rotation_degrees += speed
	parent.rotation_degrees = fmod(parent.rotation_degrees, 360)
