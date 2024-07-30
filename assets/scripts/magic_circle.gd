extends Node2D

@export var recipe_list : Node2D

@onready var point1 : Area2D = $point
@onready var point2 : Area2D = $point2
@onready var point3 : Area2D = $point3
@onready var point4 : Area2D = $point4
#@onready var point5 : Area2D = $point5
#@onready var point6 : Area2D = $point6

var potion_id : int 

func _process(delta):
	potion_id = 0
	if point1.is_clicked:
		potion_id += 1
	if point2.is_clicked:
		potion_id += 2
	if point3.is_clicked:
		potion_id += 4
	if point4.is_clicked:
		potion_id += 8
	#if point5.is_clicked:
		#potion_id += 16
	#if point6.is_clicked:
		#potion_id += 32
	
	if recipe_list:
		recipe_list.potion_id = potion_id
		
func reset():
	point1.sprite.visible = false
	point1.is_clicked = false
	point2.sprite.visible = false
	point2.is_clicked = false
	point3.sprite.visible = false
	point3.is_clicked = false
	point4.sprite.visible = false
	point4.is_clicked = false
	#point5.sprite.visible = false
	#point5.is_clicked = false
	#point6.sprite.visible = false
	#point6.is_clicked = false
