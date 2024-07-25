extends Node2D

var count : int
var potion_id : int = 5
var potion : Node
@onready var text : RichTextLabel = $RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	if potion_id:
		potion = load("res://assets/nodes/potions/" + str(potion_id) + ".tscn").instantiate()
		text.text = potion.potion_name + " - " + str(potion.value) + " gold"


