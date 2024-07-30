extends Area2D

@export var is_sell : bool = false
@export var potions : Node2D

@onready var text : RichTextLabel = $RichTextLabel
@onready var sound : AudioStreamPlayer = $AudioStreamPlayer


func _on_mouse_entered():
	text.modulate = Color(1,1,0)
	
func _on_mouse_exited():
	text.modulate = Color(1,1,1)

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		var potions_chosen : Array = potions.get_chosen()
		if !is_sell:
			get_parent().get_parent().potions_in_use = potions_chosen
			get_parent().get_parent().next_room()
		else:
			var value : int = 0
			for potion in potions_chosen:
				var link = "res://assets/nodes/potions/" + str(potion) + ".tscn"
				var pot = load(link).instantiate()
				value += pot.value
			get_parent().get_parent().get_parent().coins += value
			if (sound.get_playback_position() > 1 or !sound.playing)and value > 0:
				sound.play()
		potions.reset()
				
