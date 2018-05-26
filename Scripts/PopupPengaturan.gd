extends Control

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_BtnSaveGame_pressed():
	var game_data = get_parent().game_data
	FileManager.save_data(game_data)
	$Notifikasi.show()
	print("OK!!")


func _on_BtnKembali_pressed():
	queue_free()
	get_tree().paused = false


func _on_BtnExit_pressed():
	queue_free()
	Transition.fade_to("res://Scenes/MainMenuGame.tscn")
	get_tree().paused = false
