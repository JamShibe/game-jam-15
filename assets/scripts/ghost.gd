extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ghosting()

#Copies sprite and attributes of sprite it is ghosting (e.g rotation and size)
func set_property(tx_pos, tx_scale, tx_frame_num, tx_frames, tx_animation, tx_rotation):
	sprite_frames = tx_frames
	animation = tx_animation
	frame = tx_frame_num
	position = tx_pos
	scale = tx_scale
	rotation = tx_rotation
	
#Makes the ghost fade away after 0.25 seconds
func ghosting():
	var tween_fade = get_tree().create_tween()
	tween_fade.tween_property(self, "self_modulate",Color(1,1,1,0), 0.25)
	#Deletes node once fully faded
	await tween_fade.finished
	queue_free()
