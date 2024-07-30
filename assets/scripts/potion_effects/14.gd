extends Node

var potion_name : String = "Potion of Poison"
var ingredients : Array = [1,0,2,0,0,2]
var type : String = "[Throwable]"
var value : int = 80

var duration : int = 5

@export var poison : PackedScene

func _ready():
	if poison:
		var new_poison = poison.instantiate()
		get_parent().add_child(new_poison)
		new_poison.global_position = get_parent().global_position
		await get_tree().create_timer(duration).timeout
		new_poison.queue_free()
		queue_free()

func effect():
	if "speed_modifier" in get_parent():
		get_parent().sprite.modulate = Color(0,0.75,0)
		get_parent().speed_modifier -= 5

func _on_timer_timeout():
	get_parent().health -= 5
