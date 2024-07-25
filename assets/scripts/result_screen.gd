extends Node2D

@export var magic_circle : Node2D

@onready var potion : AnimatedSprite2D = $Outline
@onready var contents : AnimatedSprite2D = $Outline/Contents
@onready var text : RichTextLabel = $RichTextLabel

var list_of_none_potions : Array = [0,1,2,4,8,16,32]

func _process(delta):
	if "potion_id" in magic_circle:
		if magic_circle.potion_id in list_of_none_potions:
			potion.visible = false
			text.text = ""
		else:
			potion.visible = true
			if magic_circle.potion_id:
				var link = "res://assets/nodes/potions/" + str(magic_circle.potion_id) + ".tscn"
				var potion = load(link)
				if potion:
					potion = potion.instantiate()
					if potion.potion_name and potion.type:
						text.text = "[center]" + potion.potion_name + "\n" + potion.type + "[/center]"
					potion.queue_free()
					
			
		
