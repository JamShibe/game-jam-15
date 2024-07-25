extends Node

var potion_name : String = "Potion of Blind Affection"
var ingredients : Array = [0,2,1,1,0,0]
var type : String = "[Throwable]"
var value : int = 70

var duration : int = 5

@export var hearts : PackedScene

func _ready():
	if hearts:
		var new_hearts = hearts.instantiate()
		get_parent().add_child(new_hearts)
		new_hearts.global_position = get_parent().global_position
		await get_tree().create_timer(duration).timeout
		new_hearts.queue_free()
		queue_free()

func effect():
	if "charmed" in get_parent():
		get_parent().charmed = true

