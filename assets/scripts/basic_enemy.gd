extends CharacterBody2D

const SPEED = 75

@export var ghost_node : PackedScene
@export var player : Node2D

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var raycast : RayCast2D = $LineOfSite
@onready var timer : Timer = $Timer
@onready var flash_timer : Timer = $flashTimer
@onready var attack_timer : Timer = $attackTimer
@onready var attack_cool : Timer = $attackCooldown
@onready var ghost_timer : Timer = $ghostTimer
@onready var sprite : AnimatedSprite2D = $enemySprite

var dir : Vector2
var max_health = 100
var health : int = max_health
var damage : int = 0

#Potion Effects:
var speed_modifier : float = 0
var dmg_modifier : float = 0
var charmed : bool = false

func _physics_process(delta: float) -> void:
	
	reset()
	for child in get_children():
		if child.has_method("effect"):
			child.effect()
	
	if health <= 0:
		queue_free()
	if "position" in player:
			raycast.target_position = player.position - global_position
	if raycast.target_position.length() > 40 and attack_timer.is_stopped() and flash_timer.is_stopped():
		var next_path_pos := nav_agent.get_next_path_position()
		dir = global_position.direction_to(next_path_pos)
		set_anim()
		velocity = dir * (SPEED + speed_modifier)
		move_and_slide()
		if "started" in player:
			if raycast.get_collider() and player.started and timer.is_stopped():
				if raycast.get_collider().name == player.name:
					timer.start()
	elif !charmed:
		if !attack_timer.is_stopped() and "position" in player:
			velocity = dir * SPEED * 3
			move_and_slide()
			set_anim()
		else:
			velocity = Vector2.ZERO
			set_anim()
			if flash_timer.is_stopped() and attack_cool.is_stopped():
				flash_timer.start()
	
func make_path() -> void:
	if player:
		nav_agent.target_position = player.global_position
	
func _on_timer_timeout() -> void:
	make_path()

func set_anim() -> void:
	var up : bool = false
	var right : bool = false
	var left : bool = false
	var down : bool = false
	if velocity.x > 25:
		right = true
	elif velocity.x < -25:
		left = true
	if velocity.y > 25:
		down = true
	elif velocity.y < -25:
		up = true
		
	var current_frame = sprite.frame
	var current_progress = sprite.get_frame_progress()
	if !(up or down or left or right):
		sprite.frame = 0
		sprite.stop()
	elif(up and !down and !left and !right):
		sprite.play("moveN")
	elif(up and !down and !left and right):
		sprite.play("moveNE")
	elif(!up and !down and !left and right):
		sprite.play("moveE")
	elif(!up and down and !left and right):
		sprite.play("moveSE")
	elif(!up and down and !left and !right):
		sprite.play("moveS")
	elif(!up and down and left and !right):
		sprite.play("moveSW")
	elif(!up and !down and left and !right):
		sprite.play("moveW")
	elif(up and !down and left and !right):
		sprite.play("moveNW")
		
	sprite.set_frame_and_progress(current_frame, current_progress)
	
			
func _on_flash_timer_timeout():
	dir = global_position.direction_to(player.position)
	ghost_timer.start()
	attack_timer.start()
	damage = 20 + dmg_modifier

func _on_attack_timer_timeout():
	damage = 0
	ghost_timer.stop()
	attack_cool.start()
	
func _on_ghost_timer_timeout():
	#Creates ghost node
	var ghost = ghost_node.instantiate()
	#Set properties of the ghost so it matches sprite
	ghost.set_property(position, sprite.scale, sprite.frame, sprite.sprite_frames, sprite.animation, rotation)
	#Adds ghost into the scene
	get_tree().current_scene.add_child(ghost)

func reset():
	if health > 100:
		health = 100
	speed_modifier = 0
	dmg_modifier = 0
	sprite.scale.y = 1
	modulate = Color(1,1,1,1)
	charmed = false
