extends Control

const BANNER = "Anda memilih mesin '%s'. Mesin ini digunakan untuk memproduksi '%s'"
const B_KONFIRM = "Anda yakin akan membuka mesin produksi %s seharga %d ?"
enum status {LOCKED,UNLOCKED}
enum hasil {NOTHING,S,M,L}
enum enpabrik {PrepareKering,PrepareTepung,PrepareAgar2}
var curr_state
var index = 0
onready var pabrik_data = get_parent().game_data
var can_buy = true
var t = 1
var s
var m
var h
var day

func _ready():
	var i = 1
	for mesin in pabrik_data["pabrik"]:
		if not pabrik_data["pabrik"][mesin].has("gbr"):
			pabrik_data["pabrik"][mesin]["gbr"] = [
			"res://Assets/GameObjects/in-game/controls/pabrik/beli2/alat%d/Alat %d.png" %[i,i],
			"res://Assets/GameObjects/in-game/controls/pabrik/beli2/alat%d/Alat %d klik.png" %[i,i],
			"res://Assets/GameObjects/in-game/controls/pabrik/beli2/alat%d/Alat %d lock.png" %[i,i],
			"res://Assets/GameObjects/in-game/controls/pabrik/beli2/alat%d/Alat %d lock klik.png" %[i,i]
			]
			i+=1
	update_kepemilikan()
	s = pabrik_data.time.s
	m = pabrik_data.time.m
	h = pabrik_data.time.h
	day = pabrik_data.day
	set_process(true)

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

func update_kepemilikan():
	for x in pabrik_data["pabrik"]:
		if pabrik_data["pabrik"][x]["status"] == LOCKED:
			get_node("dftr_mesin/%s" % x).texture_normal = load(pabrik_data["pabrik"][x]["gbr"][2])
			get_node("dftr_mesin/%s" % x).texture_pressed = load(pabrik_data["pabrik"][x]["gbr"][3])
			get_node("dftr_mesin/%s" % x).texture_hover = load(pabrik_data["pabrik"][x]["gbr"][3])
			get_node("dftr_mesin/%s" % x).texture_focused = load(pabrik_data["pabrik"][x]["gbr"][3])
			pass
		elif pabrik_data["pabrik"][x]["status"] == UNLOCKED:
			get_node("dftr_mesin/%s" % x).texture_normal = load(pabrik_data["pabrik"][x]["gbr"][0])
			get_node("dftr_mesin/%s" % x).texture_pressed = load(pabrik_data["pabrik"][x]["gbr"][1])
			get_node("dftr_mesin/%s" % x).texture_hover = load(pabrik_data["pabrik"][x]["gbr"][1])
			get_node("dftr_mesin/%s" % x).texture_focused = load(pabrik_data["pabrik"][x]["gbr"][1])
			if get_node("dftr_mesin/%s" % x).has_node("unlock"):
				get_node("dftr_mesin/%s/unlock" % x).queue_free()

func _on_BtnKembali_pressed(scene):
	scene.queue_free()

var scene = [load("res://Scenes/PrepareKering.tscn"),
	load("res://Scenes/PrepareTepung.tscn"),
	load("res://Scenes/PrepareProduk.tscn")
]

func _on_BtnPrepareProduksi_pressed():
	var s = scene[index].instance()
	self.add_child(s)
	s.get_node("btnKembali").connect("pressed",self,"_on_BtnKembali_pressed",[s])
	s.show()
	pass

func _on_btnClose_pressed():
	var data = pabrik_save()
	get_parent().game_data = data
	queue_free()

func _on_BtnMenu_pressed():
	$Label.show()
	$bg._set_playing(true)
	$bg.set_animation("riset")
	$BtnMenu.hide()
	$ProgressBar.hide()
	$BtnProduksi.hide()
	$mesin.stop()
	$mesin.set_frame(0)
	$mesin.hide()
	$dftr_mesin.show()

func _on_DaftarMesin_pressed(mesin,tombol):
	$Label.text = BANNER %[mesin.to_upper(),mesin.to_upper()]
	if pabrik_data["pabrik"][tombol]["status"] == LOCKED:
		get_node("dftr_mesin/%s/unlock" % tombol).show()
		return
	match tombol:
		"m_kering":
			curr_state = PrepareKering
		"m_tepung":
			curr_state = PrepareTepung
		"m_agar2":
			curr_state = PrepareAgar2
	index = curr_state
	$dftr_mesin.hide()
	$Label.hide()
	$bg._set_playing(false)
	$bg.set_animation("default")
	$bg.set_frame(index)
	$ProgressBar.show()
	$BtnProduksi.show()
	$BtnMenu.show()
	$mesin.set_animation(tombol)
	$mesin.show()
	$mesin.play()
	print($mesin.frames.resource_name)

func _on_unlock_pressed(mesin):
	var harga = pabrik_data["pabrik"][mesin]["harga"]
	if harga > pabrik_data.money :
		can_buy = false
		$Konfirmasi.dialog_text = "Tidak cukup uang untuk membeli mesin %s. Uangmu hanya %d" %[mesin,pabrik_data.money]
		$Konfirmasi.show()
		return
	$Konfirmasi.dialog_text = B_KONFIRM %[mesin.to_upper(), harga]
	can_buy = true
	get_tree().set_pause(true)
	$Konfirmasi.get_close_button().connect("pressed",self,"_on_KonfirmasiCancel_pressed")
	$Konfirmasi.get_cancel().connect("pressed",self,"_on_KonfirmasiCancel_pressed")
	$Konfirmasi.get_ok().connect("pressed",self,"_on_Konfirmasi_confirmed",[mesin,harga])
	$Konfirmasi.show()
	print(harga)
	
func pabrik_save():
	var data = pabrik_data
	for mesin in data["pabrik"]:
		for item in data["pabrik"][mesin]:
			if item.match("gbr"):
				data["pabrik"][mesin].erase(item)
	data.time.h = h
	data.time.m = m
	data.time.s = s
	data.day = day
	return data

func _on_KonfirmasiCancel_pressed():
	get_tree().set_pause(false)

func _on_Konfirmasi_confirmed(mesin,harga):
	if can_buy:
		get_tree().set_pause(false)
		$Label.text = "Berhasil membeli mesin %s" % mesin
		print("sebelumnya: %d"%get_parent().game_data["money"])
		pabrik_data["pabrik"][mesin]["status"] = UNLOCKED
		pabrik_data["money"] -= harga
		print("setelahnya: %d"%get_parent().game_data["money"])
		update_kepemilikan()
	
