extends AnimatedSprite2D

@onready var parent : Node2D = get_parent()

var health : int
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if "health" in parent:
		var health = parent.health
		if health > 90:
			frame = 0
		elif health > 80:
			frame = 1
		elif health > 70:
			frame = 2
		elif health > 60:
			frame = 3
		elif health > 50:
			frame = 4
		elif health > 40:
			frame = 5
		elif health > 30:
			frame = 6
		elif health > 20:
			frame = 7
		elif health > 10:
			frame = 8
		elif health > 0:
			frame = 9
		
