extends Area2D

@export var is_shop : bool = false

@onready var text : RichTextLabel = $RichTextLabel

func _on_mouse_entered():
	text.modulate = Color(1,1,0)
	
func _on_mouse_exited():
	text.modulate = Color(1,1,1)

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		if is_shop:
			get_parent().get_parent().save_ingredients()
		else:
			get_parent().get_parent().shop()
