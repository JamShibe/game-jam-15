extends Node

var duration : int = 10

func apply_effect(target : CharacterBody2D) -> void:
	if "speed_modifier" in target:
		target.speed_modifier = target.speed * 0.4
		await get_tree().create_timer(duration).timeout
