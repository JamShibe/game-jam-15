extends Node

var potion_name : String = "Potion of Fire"
var ingredients : Array = [0,0,5,1,0,0]
var type : String = "[Throwable]"
var value : int = 80

var duration : int = 5

@export var fire : PackedScene

func _ready():
	if fire:
		var new_fire = fire.instantiate()
		get_parent().add_child(new_fire)
		new_fire.global_position = get_parent().global_position
		await get_tree().create_timer(duration).timeout
		new_fire.queue_free()
		queue_free()

func effect():
	get_parent().modulate = Color(1,0.5,0)

func _on_timer_timeout():
	get_parent().health -= 5
