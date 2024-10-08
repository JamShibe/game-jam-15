extends Area2D

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var sound : AudioStreamPlayer = $sound

var poss_ing : Array = ["Cave Moss", "Dock Leaf", "Cindered Coal", "Hollowed Bone", "Magic-Imbued Ice", "Giant Spider Fang"]
var ing_name : String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	ing_name = poss_ing.pick_random()
	sprite.play(ing_name)
	sound.stream = load("res://assets/sounds/ingredients/" + ing_name + ".mp3")

func _on_body_entered(body):
	if body.name == "player":
		body.pickup(ing_name)
		visible = false
		sound.play()
		await get_tree().create_timer(1).timeout
		queue_free()
