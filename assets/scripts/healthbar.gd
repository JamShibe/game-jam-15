extends AnimatedSprite2D

@onready var parent : Node2D = get_parent()

var health : int
var multiplier : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if "health" in parent and "max_health" in parent:
		multiplier = parent.max_health / 100
		var health = parent.health
		visible = true
		if health > 90 * multiplier:
			frame = 0
			visible = false
		elif health > 80 * multiplier:
			frame = 1
		elif health > 70 * multiplier:
			frame = 2
		elif health > 60 * multiplier:
			frame = 3
		elif health > 50 * multiplier:
			frame = 4
		elif health > 40 * multiplier:
			frame = 5
		elif health > 30 * multiplier:
			frame = 6
		elif health > 20 * multiplier:
			frame = 7
		elif health > 10 * multiplier:
			frame = 8
		elif health > 0 * multiplier:
			frame = 9
		
