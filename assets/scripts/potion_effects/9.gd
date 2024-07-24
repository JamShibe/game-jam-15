extends Node

var potion_name : String = "Simple Health Potion"
var ingredients : Array = [1,1,0,0,0,0]
var type : String = "[Drinkable]"

var duration : int = 5

func _ready():
		if "health" in get_parent():
			get_parent().health += 10
		queue_free()
