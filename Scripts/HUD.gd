extends Control

onready var money = get_parent().game_data.money
var day
var time

signal koin
signal hari
signal waktu
var t = 1
var s
var m
var h

func _ready():
	day = get_parent().game_data.day
	time = get_parent().game_data.time
	s = time.s
	m = time.m
	h = time.h
	connect("koin",self,"on_koin_changed")
	on_koin_changed()
	on_waktu_changed()
	set_process(true)
	pass

func _process(delta):
	if t > 0 :
#		print(delta)
		t -= 100 * delta
		if t < 0:
			s += 1
			if (s>=60):
				s = 0
				m += 1
			if (m >=60):
				m = 0
				h += 1
			if (h >= 24):
				h = 0
				day += 1
			t = 1
		if s<10:
			$LblTime.text = "%d:%d:0%d" %[h,m,s]
		if m<10:
			$LblTime.text = "%d:0%d:%d" %[h,m,s]
		$LblTime.text = "%d:%d:%d" %[h,m,s]
	if Utils.get_player().has("game_state"):
		if money != Utils.get_player().money:
			print("uangberubah")
			emit_signal("koin")
		if day != Utils.get_player().day:
			emit_signal("hari")
	else:
		emit_signal("koin")
#		on_waktu_changed()
	pass

func on_koin_changed():
	money = get_parent().game_data.money
	$LblCoin.text = str(get_parent().game_data.money)
	pass

func on_waktu_changed():
	if Utils.get_player().has("game_state"):
		set_process(false)
		var time = Utils.get_player().time
		s = time.s
		m = time.m
		h = time.h
		if s<10:
			$LblTime.text = "%d:%d:0%d" %[h,m,s]
		if m<10:
			$LblTime.text = "%d:0%d:%d" %[h,m,s]
			$LblTime.text = "%d:%d:%d" %[h,m,s]
		set_process(true)
	pass

func _on_BtnMenu_pressed():
	var popup_menu = load("res://Scenes/PopupPengaturan.tscn")
	if not get_parent().has_node("PopupPengaturan"):
			var child = popup_menu.instance()
			child.set_time_data(get_time_now(),get_day_now())
			get_parent().add_child(child)
			get_parent().get_node("PopupPengaturan").show()
			get_tree().paused = true


func _on_BtnGudang_pressed():
	var gudang = load("res://Scenes/GameObjects/GudangControl.tscn")
	if not get_parent().has_node("GudangControl"):
			var child = gudang.instance()
			get_parent().add_child(child)
			get_parent().get_node("GudangControl").show()

func get_day_now():
	return day

func get_time_now():
	var time = {
		"h":h,
		"m":m,
		"s":s
	}
	return time