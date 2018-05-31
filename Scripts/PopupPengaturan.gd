extends Control

var cur_time
var cur_day

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_BtnSaveGame_pressed():
	var game_data = get_parent().game_data
	game_data.time = cur_time
	FileManager.save_data(game_data)
	$Notifikasi.show()
	print("OK!!")

func set_time_data(time,day):
	cur_time = time
	cur_day = day
	pass


func _on_BtnKembali_pressed():
	queue_free()
	get_tree().paused = false


func _on_BtnExit_pressed():
	get_parent().queue_free()
	Transition.fade_to("res://Scenes/MainMenuGame.tscn")
	get_tree().paused = false
