extends Node

var duration : int = 5

func _ready():
		await get_tree().create_timer(duration).timeout
		get_parent().sprite.scale.y = 1
		queue_free()
	
func effect():
	if "speed_modifier" in get_parent():
		get_parent().speed_modifier -= 5
		get_parent().sprite.scale.y = 0.8
