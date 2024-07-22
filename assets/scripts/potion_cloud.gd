extends Area2D

@onready var effects : Array = get_children()
@onready var duration_timer : Timer = $duration

var duration : float = 5

func _ready():
	duration_timer.wait_time = duration
	duration_timer.start()

func _on_body_entered(body):
	for child in effects:
		if child.has_method("apply_effect"):
			child.apply_effect(body)

func _on_duration_timeout():
	queue_free()
