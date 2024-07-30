extends Node2D



func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		get_parent().load_tutorial()
