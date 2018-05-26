extends Area2D

enum list_tools {BIBIT, NUTRIEN, PEMANEN, PUPUK}
export (list_tools) var tipe_tools

func _ready():
	match tipe_tools:
		list_tools.BIBIT:
			$Sprite.animation = "bibit"
		list_tools.NUTRIEN:
			$Sprite.animation = "nutrien"
		list_tools.PEMANEN:
			$Sprite.animation = "panen"
		list_tools.PUPUK:
			$Sprite.animation = "pupuk"
	
	self.position = get_global_mouse_position()
	set_process_input(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass

func _input(event):
	if event.is_class("InputEventMouseMotion"):
		position = event.position
	if event.is_class("InputEventMouseButton"):
		# klik kiri
		if event.get_button_index() == BUTTON_LEFT and event.is_pressed():
			$Sprite.play()
			print("kiri!")
			pass
		# klik kanan
		if event.get_button_index() == BUTTON_RIGHT and event.is_pressed():
			queue_free()
			print("kanan!")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			pass
		pass
		

func _on_input_event(viewport, event, shape_idx):
	pass # replace with function body


func _on_Sprite_animation_finished():
	$Sprite.set_frame(0)
	$Sprite.playing = false
