extends Node

var potion_name : String = "Potion of Strength"
var ingredients : Array = [1,0,2,0,0,0]
var type : String = "[Drinkable]"

var duration : int = 5

func _ready():
		await get_tree().create_timer(duration).timeout
		queue_free()
	
func effect():
	if "dmg_modifier" in get_parent():
		get_parent().dmg_modifier += 20

