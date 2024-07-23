extends Node

var duration : int = 5

func _ready():
		if "health" in get_parent():
			get_parent().health += 10
		queue_free()
