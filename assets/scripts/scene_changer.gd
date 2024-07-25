extends Node

var number_of_rooms : int = 4
var link : String
var current_level
var changing_level : bool = false
var ingredients : Array
var shop_ingredients : Array
var health : int

@onready var trans : ColorRect = $SceneTransition

func _ready():
	next_room()

func next_room():
	if !changing_level:
		changing_level = true
		trans.play()
		if current_level:
			var player : CharacterBody2D = current_level.find_child("player")
			if player:
				ingredients = player.ing_list
				health = player.health
			await get_tree().create_timer(1).timeout
			current_level.queue_free()
		link = "res://assets/scenes/dungeons/" + str((randi() % number_of_rooms) + 1) + ".tscn"
		await get_tree().create_timer(1).timeout
		var next_room = load(link).instantiate()
		var new_player = next_room.find_child("player")
		if new_player and ingredients and health:
			new_player.ing_list = ingredients
			new_player.health = health
		add_child(next_room)
		current_level = next_room
		trans.play_back()
		changing_level = false
	
func death():
	if !changing_level:
		changing_level = true
		trans.play()
		await get_tree().create_timer(1).timeout
		if current_level:
			var player : CharacterBody2D = current_level.find_child("player")
			if player:
				ingredients = player.ing_list
		link = "res://assets/scenes/death_screen.tscn"
		await get_tree().create_timer(1).timeout
		if current_level:
			current_level.queue_free()
		var next_room = load(link).instantiate()
		var new_player = next_room.find_child("player_shop")
		if new_player and ingredients:
			new_player.ing_list = ingredients
		add_child(next_room)
		current_level = next_room
		trans.play_back()
		changing_level = false
	
func shop():
	if !changing_level:
		changing_level = true
		trans.play()
		await get_tree().create_timer(1).timeout
		if current_level:
			var player : CharacterBody2D = current_level.find_child("player_shop")
			if player:
				ingredients = player.ing_list
			current_level.queue_free()
		link = "res://assets/scenes/test_shop.tscn"
		await get_tree().create_timer(1).timeout
		var next_room = load(link).instantiate()
		var new_player = next_room.find_child("player_shop")
		if new_player and ingredients:
			new_player.ing_list = shop_ingredients + ingredients
		add_child(next_room)
		current_level = next_room
		trans.play_back()
		changing_level = false
	
func save_ingredients():
	var new_player = current_level.find_child("player_shop")
	shop_ingredients = new_player.ing_list
	next_room()
