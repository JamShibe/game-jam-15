extends Node2D


var chosen : bool = false
@onready var text : RichTextLabel = $RichTextLabel
@onready var scene_manager = get_parent().get_parent().get_parent()
@export var num : int 

# Called when the node enters the scene tree for the first time.

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		if num == 0 and scene_manager.coins >= 150:
			scene_manager.coins -= 150
			scene_manager.max_health += 100
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)
		if num == 1 and scene_manager.coins >= 200:
			scene_manager.coins -= 200
			scene_manager.drink_cooldown = 15
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)
		if num == 2 and scene_manager.coins >= 250:
			scene_manager.coins -= 250
			scene_manager.throw_cooldown = 10
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)
		if num == 3 and scene_manager.coins >= 500:
			scene_manager.coins -= 500
			scene_manager.max_health += 100
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)


func _on_area_2d_mouse_entered():
	if !chosen:
		text.modulate = Color(1,1,0)

func _on_area_2d_mouse_exited():
	if !chosen:
		text.modulate = Color(1,1,1)
		
		
func _ready():
	if num == 0:
		text.text = "double health - 150 gold"
		if scene_manager.max_health >= 200:
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)
	if num == 1:
		text.text = "Quicker Drinks - 200 gold"
		if scene_manager.drink_cooldown < 20:
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)
	if num == 2:
		text.text = "Quicker Throws - 250 gold"
		if scene_manager.throw_cooldown < 15:
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)
	if num == 3:
		text.text = "More Health! - 500 gold"
		if scene_manager.max_health >= 300:
			chosen = true
			text.text = "\nPURCHASED!"
			text.modulate = Color(0,1,0)
