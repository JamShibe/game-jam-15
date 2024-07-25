extends Area2D

@onready var effects : Array = get_children()
@onready var duration_timer : Timer = $duration

var duration : float = 8
var cloud_duration : float = 5
var effects_id : Array = [15]
var already_affected : Array = []

func _ready():
	duration_timer.wait_time = cloud_duration
	duration_timer.start()

func _on_body_entered(body):
	if !(body in already_affected):
		for id in effects_id:
			var link = "res://assets/nodes/potions/" + str(id) + ".tscn"
			var effect = load(link).instantiate()
			if!(body.find_child(effect.name)):
				if "duration" in effect:
					effect.duration = duration
				body.add_child(effect)
		already_affected.append(body)

func _on_duration_timeout():
	queue_free()
