extends CharacterBody2D

#Imports nodes in "player" Inspector (Menu on the right when u click on player)
@export var ghost_node : PackedScene

#Imports some child nodes
@onready var sprite : AnimatedSprite2D = $playerSprite
@onready var dash_cooldown : Timer = $dashCooldown
@onready var dash_duration : Timer = $dashDuration
@onready var ghost_cooldown : Timer = $ghostCooldown
@onready var sizzle_time : Timer = $sizzleTime
@onready var invun_time : Timer = $invunTimer

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
	
	#Checks to see if the player is using the dash:
	if Input.is_action_pressed("dash"):
		dash();
		
	if Input.is_action_pressed("right_click"):
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
		elif input_vector == Vector2(1,1):
			sprite.play("moveSE")
		elif input_vector == Vector2(1,0):
			sprite.play("moveE")
		elif input_vector == Vector2(1,-1):
			sprite.play("moveNE")
		elif input_vector == Vector2(0,-1):
			sprite.play("moveN")
		elif input_vector == Vector2(-1,-1):
			sprite.play("moveNW")
		elif input_vector == Vector2(-1,0):
			sprite.play("moveW")
		elif input_vector == Vector2(-1,1):
			sprite.play("moveSW")
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
	speed_modifier = 0
	dmg_modifier = 0
