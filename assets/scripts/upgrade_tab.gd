extends Node2D


var chosen : bool = false
@onready var text : RichTextLabel = $RichTextLabel
@onready var scene_manager = get_parent().get_parent().get_parent()
@export var num : int 

# Called when the node enters the scene tree for the first time.

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		chosen = true
		text.text = "\nPURCHASED!"
		text.modulate = Color(0,1,0)
		if num == 0:
			scene_manager.max_health += 100


func _on_area_2d_mouse_entered():
	if !chosen:
		text.modulate = Color(1,1,0)

func _on_area_2d_mouse_exited():
	if !chosen:
		text.modulate = Color(1,1,1)
		
		
