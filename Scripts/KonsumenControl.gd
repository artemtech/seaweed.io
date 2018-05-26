extends Control

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_btnClose_pressed():
	queue_free()
