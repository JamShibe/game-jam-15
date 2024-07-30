extends CharacterBody2D

@export var ghost_node : PackedScene

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ghostTime : Timer = $ghostTime

var target : CharacterBody2D

var damage : float = 20
var reached : bool = false
const SPEED = 100

func _ready():
	var dir = global_position.direction_to(target.global_position)
	velocity = dir * SPEED

func _physics_process(delta):
	var dir = global_position.direction_to(target.global_position)
	var dist = global_position.distance_to(target.global_position)
	if dist > 40:
		if reached == true:
			if dist > 60:
				queue_free()
		else:
			velocity = dir * SPEED
	else:
		reached = true
	move_and_slide()
	rotation_degrees += 0.5


func _on_ghost_time_timeout():
	#Creates ghost node
	var ghost = ghost_node.instantiate()
	#Set properties of the ghost so it matches sprite
	ghost.set_property(position, sprite.scale, sprite.frame, sprite.sprite_frames, sprite.animation, rotation)
	#Adds ghost into the scene
	get_tree().current_scene.add_child(ghost)


func _on_area_2d_body_entered(body):
	if body.name == "player":
		body.health -= 10
		queue_free()
