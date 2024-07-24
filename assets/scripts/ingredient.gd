extends Area2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var poss_ing : Array = ["Cave Moss", "Dock Leaf", "Cindered Coal", "Hollowed Bone", "Magic-Imbued Ice", "Giant Spider Fang"]
var ing_name : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	ing_name = poss_ing.pick_random()
	sprite.play(ing_name)

func _on_body_entered(body):
	if body.name == "player":
		body.pickup(ing_name)
		queue_free()
