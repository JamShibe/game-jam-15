extends Area2D

#Get parent
@onready var parent : Node2D = get_parent()

#Get collider for light's range/danger area
@onready var light_range : CollisionShape2D = $LightRange
@onready var light_ray : RayCast2D = $LightRay

#define other variables
var bodies_in_range
var ray_rotation : int
var range : int
var angle : int
var two_way : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if "range" in parent:
		range = parent.range
	else:
		range = 50
	if "angle" in parent:
		angle = parent.angle
	else:
		angle = -1
	if "two_way" in parent:
		two_way = parent.two_way
	else:
		two_way = false
	light_range.shape.radius = range

func _physics_process(delta):
	if has_overlapping_bodies():
		bodies_in_range = get_overlapping_bodies()
		for body in bodies_in_range:
			if body.has_method("sizzle"):
				light_ray.target_position = body.position - global_position
				light_ray.rotation = -get_parent().rotation
				if light_ray.get_collider():
					if light_ray.get_collider().name == body.name:
						if angle > 0:
							var ray_rotation = rad_to_deg(position.angle_to_point(light_ray.target_position)) - get_parent().rotation_degrees
							if two_way:
								ray_rotation = fmod(ray_rotation,180)
							if (ray_rotation < angle and (ray_rotation > -angle) or (ray_rotation > -180 and ray_rotation < -180 + angle and two_way)):
								body.sizzle(true)
						else:
							body.sizzle(true)
						
			
			
