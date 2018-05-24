extends Control

var popup_menu = load("res://Scenes/PopupPengaturan.tscn")
var gudang = load("res://Scenes/GameObjects/GudangControl.tscn")
onready var money = get_parent().game_data.money
onready var day = get_parent().game_data.day
onready var time = get_parent().game_data.time

signal koin
signal hari
signal waktu

func _ready():
	connect("koin",self,"on_koin_changed")
	set_process(true)
	pass

var t = 1
var s = 0
var m = 0
var h = 0
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
		on_koin_changed()
	pass

func on_koin_changed():
	money = get_parent().game_data.money
	$LblCoin.text = str(get_parent().game_data.money)
	pass


func _on_BtnMenu_pressed():
	if not get_parent().has_node("PopupPengaturan"):
			var child = popup_menu.instance()
			get_parent().add_child(child)
			get_parent().get_node("PopupPengaturan").show()
			get_tree().paused = true


func _on_BtnGudang_pressed():
	if not get_parent().has_node("GudangControl"):
			var child = gudang.instance()
			get_parent().add_child(child)
			get_parent().get_node("GudangControl").show()
