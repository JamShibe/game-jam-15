extends Area2D

@export var currentCam : PhantomCamera2D
@export var nextCam : PhantomCamera2D

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		currentCam.priority = 0
		nextCam.priority = 1
