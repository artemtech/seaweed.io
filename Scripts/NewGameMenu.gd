extends Node

func _ready():
	pass

func _on_Button_pressed():
	Transition.fade_to("res://Scenes/MainMenuGame.tscn")
