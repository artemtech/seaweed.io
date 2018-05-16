extends "res://Scripts/GameObjects.gd"
onready var gudangcontrol = load("res://Scenes/GameObjects/GudangControl.tscn")

func _ready():
	pass
	

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
#		print("wkwkwkwk")
		if not get_parent().has_node("GudangControl"):
			var child = gudangcontrol.instance()
			get_parent().add_child(child)
			get_parent().get_node("GudangControl").show()
			get_tree().paused = true
#		$BankControl.show()
