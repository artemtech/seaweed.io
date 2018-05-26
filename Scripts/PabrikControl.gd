extends Control

enum pabrik {PrepareKering,PrepareTepung,PrepareAgar2}
export (pabrik) var curr_state = PrepareKering
var index = 0

func _ready():
	$BtnPrev.hide()
	$BtnNext.show()
	curr_state = PrepareKering
	pass

func _on_BtnKembali_pressed(scene):
	scene.queue_free()

# laman awal ke prepare produksi
func _on_BtnPrepareProduksi_pressed():
	var scene = [load("res://Scenes/PrepareKering.tscn"),
	load("res://Scenes/PrepareTepung.tscn"),
	load("res://Scenes/PrepareProduk.tscn"),
	]
	var s = scene[index].instance()
	self.add_child(s)
	s.get_node("btnKembali").connect("pressed",self,"_on_BtnKembali_pressed",[s])
	s.show()
	pass

func _on_BtnNext_pressed():
	if index < pabrik.size() - 1:
		index += 1
		curr_state = pabrik.keys()[index]
		$BtnPrev.show()
	if index == pabrik.size() - 1:
		$BtnNext.hide()
	$bg.set_frame(index)
	print(curr_state)

func _on_BtnPrev_pressed():
	if index > 0:
		index -= 1
		curr_state = pabrik.keys()[index]
		$BtnNext.show()
	if index == 0:
		$BtnNext.show()
		$BtnPrev.hide()
	$bg.set_frame(index)
	print(curr_state)

func _on_btnClose_pressed():
	queue_free()
