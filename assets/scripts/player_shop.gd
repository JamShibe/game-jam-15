extends CharacterBody2D

var ing_list : Array = []
var pot_list : Array = []

func get_ingredients():
	var ing_array = [0,0,0,0,0,0]
	for ingredient in ing_list:
		if ingredient == "Cave Moss":
			ing_array[0] += 1
		elif ingredient == "Dock Leaf":
			ing_array[1] += 1
		if ingredient == "Cindered Coal":
			ing_array[2] += 1
		if ingredient == "Hollowed Bone":
			ing_array[3] += 1
		if ingredient == "Magic-Imbued Ice":
			ing_array[4] += 1
		if ingredient == "Giant Spider Fang":
			ing_array[5] += 1
	return ing_array

func set_ingredients(ing_array : Array):
	var new_list = []
	for count in ing_array[0]:
		new_list.append("Cave Moss")
	for count in ing_array[1]:
		new_list.append("Dock Leaf")
	for count in ing_array[2]:
		new_list.append("Cindered Coal")
	for count in ing_array[3]:
		new_list.append("Hollowed Bone")
	for count in ing_array[4]:
		new_list.append("Magic-Imbued Ice")
	for count in ing_array[5]:
		new_list.append("Giant Spider Fang")
	ing_list = new_list
