extends CharacterBody2D

const SPEED = 75

@export var player : Node2D
@export var bullet : PackedScene

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var raycast : RayCast2D = $LineOfSite
@onready var timer : Timer = $Timer
@onready var flash_timer : Timer = $flashTimer
@onready var attack_cool : Timer = $attackCooldown
@onready var sprite : AnimatedSprite2D = $enemySprite
@onready var shot_sound : AudioStreamPlayer = $shot_sound

var dir : Vector2
var max_health = 50
var health : int = max_health
var damage : int = 0
var ammo : int = 3

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
		if (randi() % 101) > 60:
			var new_ingredient = load("res://assets/nodes/ingredient.tscn")
			new_ingredient.position = position
			get_parent().add_child(new_ingredient)
		queue_free()
	if "position" in player:
			raycast.target_position = player.position - global_position
	if raycast.target_position.length() > 100 and flash_timer.is_stopped():
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
		set_anim()
		if "position" in player and flash_timer.is_stopped() and attack_cool.is_stopped():
			velocity = Vector2.ZERO
			set_anim()
			flash_timer.start()
	set_anim()
	
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
	attack_cool.start()
	shot_sound.play()
	dir = global_position.direction_to(player.position)
	damage = 20 + dmg_modifier
	for x in range(ammo):
		var new_bullet = bullet.instantiate()
		new_bullet.target = player
		new_bullet.global_position = global_position
		get_parent().add_child(new_bullet)
		await get_tree().create_timer(0.2).timeout
	
	

func reset():
	if health > max_health:
		health = max_health
	speed_modifier = 0
	dmg_modifier = 0
	sprite.scale.y = 1
	modulate = Color(1,1,1,1)
	charmed = false
