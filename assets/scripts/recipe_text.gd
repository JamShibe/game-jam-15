extends Node2D

var potion_id : int 
var Ingredients : Array

@onready var text : RichTextLabel = $RichTextLabel

@export var button : Area2D

var list_of_none_potions : Array = [0,1,2,4,8,16,32]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if potion_id:
		if !(potion_id in list_of_none_potions):
			var link = "res://assets/nodes/potions/" + str(potion_id) + ".tscn"
			var potion = load(link)
			if potion:
				potion = potion.instantiate()
				if potion.ingredients:
					Ingredients = potion.ingredients
				potion.queue_free()
				set_text(Ingredients)
		else:
				set_text([0,0,0,0,0,0])
			

func set_text(ingr : Array):
	var string = ""
	var moss = ingr[0]
	var dock = ingr[1]
	var coal = ingr[2]
	var bone = ingr[3]
	var ice = ingr[4]
	var fang = ingr[5]
	if moss > 0:
		string = string + str(moss) + " Cave Moss\n"
	if dock > 0:
		string = string + str(dock) + " Dock Leaf\n"
	if coal > 0:
		string = string + str(coal) + " Cindered Coal\n"
	if bone > 0:
		string = string + str(bone) + " Hollowed Bone\n"
	if ice > 0:
		string = string + str(ice) + " Mana-Imbued Ice\n"
	if fang > 0:
		string = string + str(fang) + " Giant Spider Fang\n"
	text.text = string
	button.check_recipe()
