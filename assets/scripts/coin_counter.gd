extends Node2D

@onready var scene_manager : Node = get_parent().get_parent().get_parent()
@onready var text : RichTextLabel = $Money

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if "coins" in scene_manager:
		text.text = str(scene_manager.coins) + " gold"
		
