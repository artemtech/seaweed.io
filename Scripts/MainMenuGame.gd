extends Node

func _ready():
	$PopupExit.get_cancel().connect("pressed",self,"_onPopupExit_cancel_pressed")
	$PopupExit.get_close_button().connect("pressed",self,"_onPopupExit_cancel_pressed")
	$PopupExit.get_label().set_align(Label.ALIGN_CENTER)
	pass

func _on_BtnNewGame_pressed():
	Transition.fade_to("res://Scenes/NewGameMenu.tscn")

func _on_BtnExit_pressed():
	$PopupExit.show()
	get_tree().paused = true

func _onPopupExit_cancel_pressed():
	get_tree().paused = false

func _on_PopupExit_confirmed():
	get_tree().quit()

