extends Node

var potion_name : String = "Potion of Slowness"
var ingredients : Array = [1,0,0,3,0,0]
var type : String = "[Throwable]"
var value : int = 60

var duration : int = 5

func _ready():
		await get_tree().create_timer(duration).timeout
		queue_free()
	
func effect():
	if "speed_modifier" in get_parent():
		get_parent().speed_modifier -= 10
