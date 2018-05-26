extends Control

var current_sken = "Awal"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_BtnPinjam_pressed():
	$TabContainer/Bank.get_node(current_sken).hide()
	current_sken = "Pinjam"
	$TabContainer/Bank.get_node(current_sken).show()

func _on_BtnKembali_pressed():
	$TabContainer/Bank.get_node(current_sken).hide()
	current_sken = "Awal"
	$TabContainer/Bank.get_node(current_sken).show()


func _on_BtnKeluar_pressed():
	queue_free()
	get_tree().paused = false


func _on_btnKembali_pressed():
	pass # replace with function body


func _on_btnKeluar_pressed():
	queue_free()
	get_tree().paused = false
