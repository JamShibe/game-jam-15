extends Area2D

var is_clicked : bool = false

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		if !is_clicked:
			sprite.visible = true
			is_clicked = true
		else:
			sprite.visible = false
			is_clicked = false
