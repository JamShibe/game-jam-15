extends Node2D

var count : int
var potion_id : int = 5
var potion : Node
var chosen : bool = false
@export var is_shop : bool = false
@onready var text : RichTextLabel = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	if potion_id:
		potion = load("res://assets/nodes/potions/" + str(potion_id) + ".tscn").instantiate()
		if is_shop:
			text.text = potion.potion_name + " - " + str(potion.value) + " gold"
		else:
			text.text = potion.potion_name + " " + str(potion.type)
		
func _on_area_2d_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		if chosen:
			chosen = false
		else:
			var checked_potions = get_parent().get_parent().get_parent().check_chosen()
			if !potion_id in checked_potions or is_shop:
				chosen = true
				text.modulate = Color(0,1,0)


func _on_area_2d_mouse_entered():
	if !chosen:
		text.modulate = Color(1,1,0)
	var checked_potions = get_parent().get_parent().get_parent().check_chosen()
	if potion_id in checked_potions and !chosen:
		text.modulate = Color(1,0,0)

func _on_area_2d_mouse_exited():
	if !chosen:
		text.modulate = Color(1,1,1)
