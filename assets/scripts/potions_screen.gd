extends Node2D

@onready var potion_inven : Node2D = $PotionInventory

@export var player : CharacterBody2D

func _ready():
	update_list()

func update_list():
	potion_inven.potions = player.pot_list
	potion_inven.reset()
