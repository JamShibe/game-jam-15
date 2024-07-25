extends Node

var potion_name : String = "Potion of Dark Vision"
var ingredients : Array = [0,0,1,0,2,0]
var type : String = "[Drinkable]"

var duration : int = 5

func _ready():
		await get_tree().create_timer(duration * 3).timeout
		queue_free()
	
func effect():
	if "light" in get_parent() and "camera" in get_parent():
		get_parent().light.texture_scale = 1
		get_parent().camera.zoom = Vector2(3,3)
