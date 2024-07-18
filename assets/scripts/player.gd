extends CharacterBody2D

#Imports nodes in "player" Inspector (Menu on the right when u click on player)
@export var ghost_node : PackedScene

#Imports some child nodes
@onready var sprite : AnimatedSprite2D = $playerSprite
@onready var dash_cooldown : Timer = $dashCooldown
@onready var dash_duration : Timer = $dashDuration
@onready var ghost_cooldown : Timer = $ghostCooldown

#Defines Original Speed constant. Speed variable will be changed via dashing and then set back to original speed
const ORIG_SPEED = 100

#Defines variables
var speed : int = ORIG_SPEED
var input_vector : Vector2
var current_frame : int
var current_progress : float

#_physics_process is run every single frame.
func _physics_process(delta):
	#Runs the move player function
	move_player()

func move_player():
	#Resets input_vector to zero
	input_vector = Vector2.ZERO
	#Uses inputs to decide which direction the player should move in.
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up");
	
	#Checks to see if the player is using the dash:
	if Input.is_action_pressed("dash"):
		dash();

	if input_vector:
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
func dash():
	#If the dash cooldown has reset:
	if dash_cooldown.is_stopped():
		#Triple the speed while dashing
		speed = ORIG_SPEED * 3
		#Start all duration/cooldown timers
		ghost_cooldown.start()
		dash_duration.start();
		dash_cooldown.start()
		
#Resets speed and stops ghosting when dash is done
func _on_dash_duration_timeout():
	ghost_cooldown.stop()
	speed = ORIG_SPEED

#Spawns a ghost every time the ghost timer loops (0.05 seconds)
func _on_ghost_cooldown_timeout():
	#Creates ghost node
	var ghost = ghost_node.instantiate()
	#Set properties of the ghost so it matches sprite
	ghost.set_property(position, sprite.scale, sprite.frame, sprite.sprite_frames, sprite.animation, rotation)
	#Adds ghost into the scene
	get_tree().current_scene.add_child(ghost)
