extends Node

func apply_effect(target : CharacterBody2D) -> void:
	if "damage" in target:
		target.damage = target.damage * 1.5
