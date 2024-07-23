extends CharacterBody2D

#Imports nodes in "player" Inspector (Menu on the right when u click on player)
@export var ghost_node : PackedScene
@export var attack_node : PackedScene

#Imports some child nodes
@onready var sprite : AnimatedSprite2D = $playerSprite
@onready var dash_cooldown : Timer = $dashCooldown
@onready var dash_duration : Timer = $dashDuration
@onready var ghost_cooldown : Timer = $ghostCooldown
@onready var sizzle_time : Timer = $sizzleTime
@onready var invun_time : Timer = $invunTimer
@onready var attack_time : Timer = $attackTimer
@onready var attack_centre : Node2D = $AttackCentre
@onready var attack_point : Node2D = $AttackCentre/AttackPoint
@onready var light : PointLight2D = $light
@onready var camera : PhantomCamera2D = get_parent().find_child("PhantomCamera2D")

#Defines Original Speed constant. Speed variable will be changed via dashing and then set back to original speed
const ORIG_SPEED = 100

#Defines variables
var speed : int = ORIG_SPEED
var input_vector : Vector2
var current_frame : int
var current_progress : float
var sizzle_amount : int = 0
var started : bool = false
var health : float = 100
var damage : float = 20
var ing_list : Array = []

#Potion Effects:
var speed_modifier : float = 0
var dmg_modifier : float = 0

#_physics_process is run every single frame.
func _physics_process(delta) -> void:
	#Runs the move player function
	sizzle(false)
	move_player()
	if health <= 0:
		#DEATH HERE
		visible = false

func move_player() -> void:
	#Resets input_vector to zero
	input_vector = Vector2.ZERO
	#Uses inputs to decide which direction the player should move in.
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up");
	
	reset()
	for child in get_children():
		if child.has_method("effect"):
			child.effect()
	
	#Checks to see if the player is using the dash:
	if Input.is_action_pressed("dash"):
		dash();
		
	if Input.is_action_pressed("left_click"):
		shoot()
		
	if Input.is_action_pressed("drink"):
		use_potion()

	if input_vector:
		#once player moves for the first time, started is set to true
		if !started:
			started = true
		#Saves the current frame/progress so we can switch between animations without restarting them
		current_frame = sprite.frame
		current_progress = sprite.get_frame_progress()
		#Checks each possible direction and switches to the correct animation
		if input_vector == Vector2(0,1):
			sprite.play("moveS")
			attack_centre.rotation_degrees = 90
		elif input_vector == Vector2(1,1):
			sprite.play("moveSE")
			attack_centre.rotation_degrees = 45
		elif input_vector == Vector2(1,0):
			sprite.play("moveE")
			attack_centre.rotation_degrees = 0
		elif input_vector == Vector2(1,-1):
			sprite.play("moveNE")
			attack_centre.rotation_degrees = -45
		elif input_vector == Vector2(0,-1):
			sprite.play("moveN")
			attack_centre.rotation_degrees = -90
		elif input_vector == Vector2(-1,-1):
			sprite.play("moveNW")
			attack_centre.rotation_degrees = -135
		elif input_vector == Vector2(-1,0):
			sprite.play("moveW")
			attack_centre.rotation_degrees = 180
		elif input_vector == Vector2(-1,1):
			sprite.play("moveSW")
			attack_centre.rotation_degrees = 135
		#Sets frame and progress to be the same so that the animation doesn't reset
		sprite.set_frame_and_progress(current_frame, current_progress)
		#Normalizes input_vector to equal one, then multiplies it by the speed and sets the velocity
		input_vector = input_vector.normalized()
		velocity = input_vector * speed
	#If the player is not moving:
	else:
		#Set the velocity to Zero, Stop the animation and set the frame to be standing
		velocity = input_vector
		sprite.stop()
		sprite.frame = 0
	#Calls move_and_slide, which does all the moving and physics stuff
	move_and_slide()

#Handles the dash + ghost
func dash() -> void:
	#If the dash cooldown has reset:
	if dash_cooldown.is_stopped():
		#Triple the speed while dashing
		speed = (ORIG_SPEED + speed_modifier) * 3
		#Start all duration/cooldown timers
		ghost_cooldown.start()
		dash_duration.start();
		dash_cooldown.start()
		
#Resets speed and stops ghosting when dash is done
func _on_dash_duration_timeout() -> void:
	ghost_cooldown.stop()
	speed = ORIG_SPEED + speed_modifier

#Spawns a ghost every time the ghost timer loops (0.05 seconds)
func _on_ghost_cooldown_timeout() -> void:
	#Creates ghost node
	var ghost = ghost_node.instantiate()
	#Set properties of the ghost so it matches sprite
	ghost.set_property(position, sprite.scale, sprite.frame, sprite.sprite_frames, sprite.animation, rotation)
	#Adds ghost into the scene
	get_tree().current_scene.add_child(ghost)
	
#if in light, player will start sizzling
func sizzle(is_sizzling : bool) -> void:
	if is_sizzling and sizzle_amount < 53:
		sizzle_amount += 2
		modulate = Color(1, 1, 0)
	elif sizzle_amount > 0:
		sizzle_amount -= 1
		speed = ORIG_SPEED + speed_modifier
	if sizzle_amount < 1 and dash_cooldown.is_stopped():
		modulate = Color(1, 1, 1)
		speed = ORIG_SPEED + speed_modifier
	elif sizzle_amount > 5 and dash_cooldown.is_stopped():
		speed = (ORIG_SPEED + speed_modifier) / 3
	if sizzle_amount > 50 and sizzle_time.is_stopped():
		sizzle_time.start()
	elif sizzle_amount < 50 and !sizzle_time.is_stopped():
		sizzle_time.stop()
		
func _on_sizzle_time_timeout() -> void:
	#DEATH HERE
	visible = false

func _on_hitbox_body_entered(body):
	if "damage" in body and invun_time.is_stopped():
		if body.damage > 0:
			health -= body.damage
			sprite.modulate = Color(1,0,0)
			invun_time.start()
		
func _on_invun_timer_timeout():
	sprite.modulate = Color(1,1,1)
	
func use_potion():
	if find_child("Potion"):
		find_child("Potion").use()
		
func reset():
	if health > 100:
		health = 100
	speed_modifier = 0
	dmg_modifier = 0
	light.texture_scale = 0.4
	camera.zoom = Vector2(5 , 5)

func pickup(name : String):
	ing_list.append(name)
	print(ing_list)
	
func shoot():
	if attack_time.is_stopped():
		attack_time.start()
		var attack = attack_node.instantiate()
		get_parent().add_child(attack)
		attack.global_position = attack_point.global_position
		attack.rotation = attack_centre.rotation
		var dir = global_position.direction_to(attack_point.global_position).normalized()
		attack.damage = damage + dmg_modifier
		attack.velocity = dir * 150
		
	
