extends CharacterBody2D

var target : Vector2

@export var cloud : PackedScene

@onready var collider : Area2D = $Area2D

var effects_id : Array = []
var potions : Array

func _physics_process(delta):
	if target and cloud:
		velocity = global_position.direction_to(target) * 100
		rotation_degrees += 1
		move_and_slide()
		if global_position.distance_squared_to(target) < 1:
			var new_cloud = cloud.instantiate()
			new_cloud.position = position
			get_parent().add_child(new_cloud)
			new_cloud.effects_id = effects_id
			queue_free()
			
func _on_area_2d_body_entered(body):
	var new_cloud = cloud.instantiate()
	new_cloud.position = position
	get_parent().add_child(new_cloud)
	new_cloud.effects_id = effects_id
	queue_free()
	
func set_potions():
	if potions:
		for potion in potions:
			var link = "res://assets/nodes/potions/" + str(potion) + ".tscn"
			var pot = load(link).instantiate()
			if pot.type == "[Throwable]":
				effects_id.append(potion)
