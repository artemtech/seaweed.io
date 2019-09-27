extends Node2D

func _on_BtnKeluar_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_parent().toogle_btn(true)
	queue_free()
	

func reset_peralatan():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if has_node("Bibit"):
		$Bibit.queue_free()
	if has_node("Nutrien"):
		$Nutrien.queue_free()
	if has_node("Pemanen"):
		$Pemanen.queue_free()
	if has_node("PupukA"):
		$PupukA.queue_free()
	if has_node("PupukK"):
		$PupukK.queue_free()
	if has_node("PupukN"):
		$PupukN.queue_free()
	if has_node("PupukP"):
		$PupukP.queue_free()
	if has_node("PupukU"):
		$PupukU.queue_free()

func _on_BtnPupuk_pressed():
	reset_peralatan()
	if not $ListPupuk.is_visible():
		$ListPupuk.show()
	else:
		$ListPupuk.hide()

func _on_BtnBibit_pressed():
	reset_peralatan()
	if $ListPupuk.is_visible():
		$ListPupuk.hide()
	if not has_node("Bibit"):
			var bibit = load("res://Scenes/GameObjects/Tambak/Bibit.tscn")
			var child = bibit.instance()
			add_child(child)

func _on_BtnNutrien_pressed():
	reset_peralatan()
	if $ListPupuk.is_visible():
		$ListPupuk.hide()
	if not has_node("Nutrien"):
			var nutrien = load("res://Scenes/GameObjects/Tambak/Nutrien.tscn")
			var child = nutrien.instance()
			add_child(child)

func _on_BtnPanen_pressed():
	reset_peralatan()
	if $ListPupuk.is_visible():
		$ListPupuk.hide()
	if not has_node("Pemanen"):
			var pemanen = load("res://Scenes/GameObjects/Tambak/Pemanen.tscn")
			var child = pemanen.instance()
			add_child(child)
	pass # replace with function body

func _on_BtnAmino_pressed():
	reset_peralatan()
	if not has_node("PupukA"):
			var pupuk_a = load("res://Scenes/GameObjects/Tambak/PupukA.tscn")
			var child = pupuk_a.instance()
			add_child(child)

func _on_BtnKalium_pressed():
	reset_peralatan()
	if not has_node("PupukK"):
			var pupuk_k = load("res://Scenes/GameObjects/Tambak/PupukK.tscn")
			var child = pupuk_k.instance()
			add_child(child)

func _on_BtnNitrogen_pressed():
	reset_peralatan()
	if not has_node("PupukN"):
			var pupuk_n = load("res://Scenes/GameObjects/Tambak/PupukN.tscn")
			var child = pupuk_n.instance()
			add_child(child)

func _on_BtnPosfat_pressed():
	reset_peralatan()
	if not has_node("PupukP"):
			var pupuk_p = load("res://Scenes/GameObjects/Tambak/PupukP.tscn")
			var child = pupuk_p.instance()
			add_child(child)

func _on_BtnUrea_pressed():
	reset_peralatan()
	if not has_node("PupukU"):
			var pupuk_u = load("res://Scenes/GameObjects/Tambak/PupukU.tscn")
			var child = pupuk_u.instance()
			add_child(child)

var ukuran = [0,20,30,40,50,60,70,80]

func _on_btnPlusKolam1_pressed():
	if $Kolam1.frame < $Kolam1.frames.get_frame_count("kolam") - 1:
		$Kolam1.frame += 1
		$Kolam1/Label.text = str(ukuran[$Kolam1.frame]) + "m"

func _on_btnMinusKolam1_pressed():
	if $Kolam1.frame > 0:
		$Kolam1.frame -= 1
		$Kolam1/Label.text = str(ukuran[$Kolam1.frame]) + "m"

func _on_btnPlusKolam2_pressed():
	if $Kolam2.frame < $Kolam2.frames.get_frame_count("kolam2") - 1:
		$Kolam2.frame += 1
		$Kolam2/Label.text = str(ukuran[$Kolam2.frame]) + "m"

func _on_btnMinusKolam2_pressed():
	if $Kolam2.frame > 0:
		$Kolam2.frame -= 1
		$Kolam2/Label.text = str(ukuran[$Kolam2.frame]) + "m"

var on_kolam = false

func _on_kolam1a_area_shape_entered(area_id, area, area_shape, self_shape):
	on_kolam = true
	print("yipppee")


func _on_kolam1a_input_event(viewport, event, shape_idx):
	if on_kolam:
		if event.is_class("InputEventMouseButton"):
			if event.get_button_index() == BUTTON_LEFT and event.is_pressed():
				print("OK!!")

func _on_kolam1a_area_shape_exited(area_id, area, area_shape, self_shape):
	on_kolam = false
	print("yaaahh")
