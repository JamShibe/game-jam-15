extends Node2D


func reset():
	var children = get_children()
	for child in children:
		if child.has_method("setup"):
			child.setup()
