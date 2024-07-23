extends Node

var number_of_rooms : int = 3
var link : String
var current_level
var changing_level : bool = false

@onready var trans : ColorRect = $SceneTransition

func _ready():
	next_room()

func _process(delta):
	if current_level  and !changing_level:
		if current_level.next_room:
			changing_level = true
			next_room()

func next_room():
	trans.play()
	await get_tree().create_timer(1).timeout
	if current_level:
		current_level.queue_free()
	link = "res://assets/scenes/dungeons/" + str((randi() % number_of_rooms) + 1) + ".tscn"
	print(link)
	await get_tree().create_timer(1).timeout
	var next_room = load(link).instantiate()
	add_child(next_room)
	current_level = next_room
	trans.play_back()
	changing_level = false
