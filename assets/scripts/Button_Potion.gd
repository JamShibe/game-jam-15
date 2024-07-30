extends Area2D

@export var is_shop : bool = false
@export var player : CharacterBody2D
@export var recipe : Node2D
@export var potion_list : Node2D
@export var magic_circle : Node2D

@onready var text : RichTextLabel = $RichTextLabel
@onready var sound : AudioStreamPlayer = $potion_make

var ingredients : Array
var ingredients_needed : Array
var can_make : bool = false

func _on_mouse_entered():
	check_recipe()
	if can_make:
		text.modulate = Color(0,1,0)
	else:
		text.modulate = Color(1,0,0)
		
func _on_mouse_exited():
	text.modulate = Color(1,1,1)
	
func _ready():
	visible = false
	
func check_recipe():
	ingredients = player.get_ingredients()
	ingredients_needed = recipe.Ingredients
	var count : int = 0
	can_make = true
	if ingredients.size() < 1:
		can_make = false
	else:
		for ingredient in ingredients_needed:
			if ingredients[count] < ingredient:
				can_make = false
			count +=1
		if can_make:
			visible = true
	

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		check_recipe()
		if can_make:
			var count : int = 0
			var player_ing = player.get_ingredients()
			for ingredient in ingredients_needed:
				player_ing[count] -= ingredient
				count += 1
			check_recipe()
			player.set_ingredients(player_ing)
			get_parent().get_parent().get_parent().potion_inventory.append(recipe.potion_id)
			potion_list.update_list()
			sound.play()
			magic_circle.reset()
			
		
