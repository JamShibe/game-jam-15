extends Line2D

@export var point1 : Area2D
@export var point2 : Area2D

func _process(delta):
	if "is_clicked" in point1 and "is_clicked" in point2:
		if point1.is_clicked and point2.is_clicked:
			visible = true
		else:
			visible = false
