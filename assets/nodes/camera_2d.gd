extends Camera2D

@export var player : CharacterBody2D
@onready var ui : Node2D = $UI
@onready var ui2 : Node2D = $UI2

# Called when the node enters the scene tree for the first time.
func _ready():
	ui.player = player
	ui.type = "Drinkable"
	ui2.player = player
	ui2.type = "Throwable"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
