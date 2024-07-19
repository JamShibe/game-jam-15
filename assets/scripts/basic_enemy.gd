extends CharacterBody2D

const SPEED = 75

@export var player : Node2D

@onready var nav_agent : NavigationAgent2D = $NavigationAgent2D
@onready var raycast : RayCast2D = $LineOfSite
@onready var timer : Timer = $Timer
@onready var sprite : AnimatedSprite2D = $enemySprite

func _physics_process(delta: float) -> void:
	var next_path_pos := nav_agent.get_next_path_position()
	var dir := global_position.direction_to(next_path_pos)
	set_anim()
	velocity = dir * SPEED
	move_and_slide()
	raycast.target_position = player.position - global_position
	if raycast.get_collider() and player.started and timer.is_stopped():
		if raycast.get_collider().name == player.name:
			timer.start()
	
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
		sprite.stop()
		sprite.frame = 0
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
	
		
		
	
	
	
