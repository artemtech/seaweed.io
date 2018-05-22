extends "res://Scripts/GameObjects.gd"
onready var tokocontrol = load("res://Scenes/GameObjects/KonsumenControl.tscn")

func _ready():
	pass
	

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if not get_parent().has_node("KonsumenControl"):
			var child = tokocontrol.instance()
			get_parent().add_child(child)
			get_parent().get_node("KonsumenControl").show()
			get_tree().paused = true
			
