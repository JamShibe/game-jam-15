extends Node

var number_of_rooms : int = 4
var link : String
var current_level
var changing_level : bool = false
var ingredients : Array 
var shop_ingredients : Array
var health : int
var potion_inventory : Array = [5,9,11,13,7,10]
var potions_in_use : Array = []
var max_health : float = 100
var coins : int = 100
var drink_cooldown : int = 20
var throw_cooldown : int = 15

@onready var trans : ColorRect = $SceneTransition
@onready var dungeon_music : AudioStreamPlayer = $dungeon_music
@onready var shop_music : AudioStreamPlayer = $shop_music
@onready var menu_music : AudioStreamPlayer = $menu_music
@onready var anim : AnimationPlayer = $AnimationPlayer

func _ready():
	menu_music.play()
	load_menu()

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
		add_child(next_room)
		current_level = next_room
		if new_player:
			new_player.potions_in_use = potions_in_use
		if new_player and ingredients and health:
			new_player.ing_list = ingredients
			new_player.health = health
			if potions_in_use.size() > 0:
				new_player.potions_in_use = potions_in_use
		trans.play_back()
		changing_level = false
	
func death():
	if !changing_level:
		potions_in_use = []
		changing_level = true
		trans.play()
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
		if new_player and ingredients and potion_inventory:
			new_player.ing_list = ingredients
			new_player.pot_list = potion_inventory
		add_child(next_room)
		current_level = next_room
		trans.play_back()
		if dungeon_music.playing:
			dungeon_music.stop()
		changing_level = false
	
func shop():
	if !changing_level:
		potions_in_use = []
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
		shop_music.play()
		if menu_music.playing:
			anim.play("fade_menu")
			menu_music.stop()
		else:
			anim.play("fade_dungeon")
		trans.play_back()
		changing_level = false
	
func save_ingredients():
	var new_player = current_level.find_child("player_shop")
	shop_ingredients = new_player.ing_list
	choose_screen()
	
func choose_screen():
	if !changing_level:
		changing_level = true
		trans.play()
		await get_tree().create_timer(1).timeout
		if current_level:
			var player : CharacterBody2D = current_level.find_child("player_shop")
			if player:
				ingredients = player.ing_list
			current_level.queue_free()
		link = "res://assets/scenes/potion_choosing.tscn"
		await get_tree().create_timer(1).timeout
		var next_room = load(link).instantiate()
		add_child(next_room)
		current_level = next_room
		trans.play_back()
		dungeon_music.play()
		anim.play("shop_fade")
		changing_level = false
		
func load_tutorial():
	if !changing_level:
		changing_level = true
		trans.play()
		if current_level:
			await get_tree().create_timer(1).timeout
			current_level.queue_free()
		await get_tree().create_timer(1).timeout
		link = "res://assets/scenes/tutorial.tscn"
		await get_tree().create_timer(1).timeout
		var next_room = load(link).instantiate()
		add_child(next_room)
		current_level = next_room
		trans.play_back()
		changing_level = false
		
func load_menu():
	if !changing_level:
		changing_level = true
		trans.play()
		await get_tree().create_timer(1).timeout
		link = "res://assets/scenes/main_menu.tscn"
		await get_tree().create_timer(1).timeout
		var next_room = load(link).instantiate()
		add_child(next_room)
		current_level = next_room
		trans.play_back()
		changing_level = false
		
	
#INFO
#Make shop go to potion choosing - DONE
#Make potions be used up - DONE
#Make potions used be passed thru to player, then passed thru to drink/throw based on type - DONE
#Go sleep :3 - done :3

#TODO 
#add upgrades
#add more rooms
#CHANGE ENEMY SPRITES
