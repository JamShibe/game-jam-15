extends Sprite2D

@export var ingredient : String

@onready var sprite : AnimatedSprite2D = $sprite
@onready var text : RichTextLabel = $text

var ingredients : Array
var amount : int = 0

func _ready():
	setup()
		
func setup():
	amount = 0
	var player = get_parent().get_parent().find_child("player_shop")
	if player:
		ingredients = player.ing_list
		sprite.play(ingredient)
		for ing in ingredients:
			if ingredient == ing:
				amount += 1
		text.text = ingredient + " x" + str(amount)
