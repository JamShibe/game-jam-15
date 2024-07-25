extends Node

var potion_name : String = "Potion of Calcium Deficiency"
var ingredients : Array = [0,0,0,5,1,0]
var type : String = "[Throwable]"

var duration : int = 5

func _ready():
		await get_tree().create_timer(duration).timeout
		queue_free()
	
func effect():
	print(get_parent())
	if "speed_modifier" in get_parent():
		get_parent().speed_modifier -= 5
		get_parent().sprite.scale.y = 0.5
