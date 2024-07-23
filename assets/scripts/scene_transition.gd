extends ColorRect

@onready var anim : AnimationPlayer = $AnimationPlayer

func play():
	anim.play("fade")
	
func _ready():
	anim.play_backwards("fade")

func play_back():
	anim.play_backwards("fade")
