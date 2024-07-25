extends CharacterBody2D

@export var ghost_node : PackedScene

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var damage : float = 20

func _physics_process(delta):
	move_and_slide()

func _on_ghost_timer_timeout():
	#Creates ghost node
	var ghost = ghost_node.instantiate()
	#Set properties of the ghost so it matches sprite
	ghost.set_property(position, sprite.scale, sprite.frame, sprite.sprite_frames, sprite.animation, rotation)
	#Adds ghost into the scene
	get_tree().current_scene.add_child(ghost)
	
func _on_life_timer_timeout():
	queue_free()
	
func _on_area_2d_body_entered(body):
	if "health" in body:
		body.health -= damage
	else:
		queue_free()
