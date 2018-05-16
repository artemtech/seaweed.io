extends Control

var curr_state = "awal"

func _ready():
	for nodes in get_children():
		var btn_kembali = nodes.find_node("BtnKembali")
		btn_kembali.connect("pressed",self,"_on_BtnKembali_pressed",[curr_state])
	pass

func _on_BtnKembali_pressed(var state = "awal"):
	match(state):
		# kalo di posisi awal, kita balik ke screen game
		"awal":
			queue_free()
			get_tree().paused = false
		# kalo di posisi prepare, kita balik ke awal
		"prepare":
			$TabContainer/Pabrik.show()
			$PrepareDialog.hide()
			curr_state = "awal"
	pass

# laman awal ke prepare produksi
func _on_BtnPrepareProduksi_pressed():
	curr_state = "prepare"
	$TabContainer/Pabrik.hide()
	$PrepareDialog.show()
