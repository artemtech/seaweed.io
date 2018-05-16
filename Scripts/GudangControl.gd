extends Control

func _on_BtnKeluar_pressed():
	queue_free()
	get_tree().paused = false
