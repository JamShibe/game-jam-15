extends Node

var duration : int = 5

func _ready():
		await get_tree().create_timer(duration).timeout
		queue_free()
	
func effect():
	if "dmg_modifier" in get_parent():
		get_parent().dmg_modifier += 20

