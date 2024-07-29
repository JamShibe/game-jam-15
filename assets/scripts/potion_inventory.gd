extends Node2D

@export var potion_tab : PackedScene
@export var is_shop : bool = false

@onready var control = $ScrollContainer/Control
var potions : Array = []

func _ready():
	reset()
		

func reset():
	for child in control.get_children():
		child.queue_free()
	var count = 0
	if "potion_inventory" in get_parent().get_parent().get_parent():
		potions = get_parent().get_parent().get_parent().potion_inventory
	for potion in potions:
		count += 1;
		var new_tab = potion_tab.instantiate()
		new_tab.is_shop = is_shop
		new_tab.potion_id = potion
		control.add_child(new_tab)
		var y = 10 + (((count-1)/2)  * 30)
		var x = 35
		control.custom_minimum_size.y = y + 30
		if count % 2 > 0:
			x = 125
		new_tab.position = Vector2(x,y)
		
func get_chosen():
	var chosen_potions : Array = []
	var count : int = 0
	for child in control.get_children():
		if "chosen" in child:
			if child.chosen == true:
				chosen_potions.append(child.potion_id)
				get_parent().get_parent().get_parent().potion_inventory.remove_at(get_parent().get_parent().get_parent().potion_inventory.find(child.potion_id))
		count += 1;
		
	return chosen_potions
