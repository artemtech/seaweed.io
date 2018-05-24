extends Control

var toko = {
		"bibit" : {
			"nama" : "Bibit Rumput Laut",
			"img" : "res://icon.png",
			"harga" : 500
		},
		"gula" : {
			"nama" : "Gula",
			"img" : "res://icon.png",
			"harga" : 25
		},
		"garam" : {
			"nama" : "Garam",
			"img" : "res://icon.png",
			"harga" : 25
		},
		"metil_alkohol" : {
			"nama" : "Metil Alkohol",
			"img" : "res://icon.png",
			"harga" : 25
		},
		"pewarna" : {
			"nama" : "Pewarna",
			"img" : "res://icon.png",
			"harga" : 25
		},
		"perasa" : {
			"nama" : "Perasa",
			"img" : "res://icon.png",
			"harga" : 25
		},
}
onready var goods_container = $TabContainer/Toko/ItemList/ItemContainer
onready var our_koin = $HBoxContainer/TextureRect/OurKoin
onready var our_bibit = $HBoxContainer/GridContainer/TextureRect/OurBibit
onready var our_gula = $HBoxContainer/GridContainer/TextureRect3/OurGula
onready var our_garam = $HBoxContainer/GridContainer/TextureRect4/OurGaram
onready var our_metilalkohol = $HBoxContainer/GridContainer/TextureRect5/OurMetilAlkohol
onready var our_pewarna = $HBoxContainer/GridContainer/TextureRect6/OurPewarna
onready var our_perasa = $HBoxContainer/GridContainer/TextureRect7/OurPerasa

func _ready():
	for good in toko:
		var item = VBoxContainer.new()
		item.name = good
		item.alignment =  item.ALIGN_CENTER
		
		var item_icon = TextureRect.new()
		item_icon.texture = load(toko[good].img)
		
		var item_desc = Label.new()
		item_desc.align = item_desc.ALIGN_CENTER
		item_desc.name = "deskripsi"
		item_desc.text = toko[good].nama
		
		var hcontainer = HBoxContainer.new()
		hcontainer.name = "hcontainer"
		
		var item_qty = SpinBox.new()
		item_qty.name = "item_qty"
		item_qty.rounded = true
		item_qty.connect("value_changed",self,"on_item_qty_changed",[good])
		
		
		var item_harga = Label.new()
		item_harga.name = "item_harga"
		item_harga.text = "@ $" + str(toko[good].harga)
		hcontainer.add_child(item_qty)
		hcontainer.add_child(item_harga)
		
		var item_total = Label.new()
		item_total.align = item_total.ALIGN_CENTER
		item_total.name = "item_total"
		item_total.text =  "TOTAL = "+ str(item_qty.value * toko[good].harga)
		
		var btn_beli = Button.new()
		btn_beli.name = "btn_beli"
		btn_beli.text = "BELI"
		btn_beli.connect("pressed",self,"on_btn_beli_pressed",[good])
#		btn_beli.connect("gamedata_changed",self,"refresh_game_ui")
		
		item.add_child(item_icon)
		item.add_child(item_desc)
		item.add_child(hcontainer)
		item.add_child(item_total)
		item.add_child(btn_beli)
		item.size_flags_horizontal = SIZE_EXPAND_FILL
		
		goods_container.add_child(item)
		
	refresh_game_ui()
	pass

func on_btn_beli_pressed(good):
	#TODO - kurangi koin kita - tambah inventori kita
	var total = int(goods_container.get_node("%s/item_total"%good).text.right(8))
	var qty = goods_container.get_node("%s/hcontainer/item_qty"%good).value
	if total > get_parent().game_data.money:
		$Notifikasi.connect("confirmed",self,"reset_form",[good])
		$Notifikasi.dialog_text = "Unsufficient Funds !"
		$Notifikasi.show()
		return
	get_parent().game_data.money -= total
	get_parent().game_data.gudang[good].qty += qty
	emit_signal("gamedata_changed")
	refresh_game_ui()
	reset_form(good)
	pass

func refresh_game_ui():
	our_koin.text = str(get_parent().game_data.money)
	our_bibit.text = str(get_parent().game_data.gudang.bibit.qty)
	our_gula.text = str(get_parent().game_data.gudang.gula.qty)
	our_garam.text = str(get_parent().game_data.gudang.garam.qty)
	our_metilalkohol.text = str(get_parent().game_data.gudang.metil_alkohol.qty)
	our_pewarna.text = str(get_parent().game_data.gudang.pewarna.qty)
	our_perasa.text = str(get_parent().game_data.gudang.perasa.qty)
	pass

func on_item_qty_changed(value, good):
	var total = value * toko[good].harga
	goods_container.get_node("%s/item_total"%good).text = "TOTAL = " + str(total)
	pass

func _on_BtnTutup_pressed():
	get_tree().paused = false
	self.queue_free()


func reset_form(good):
	goods_container.get_node("%s/hcontainer/item_qty"%good).value = 0
	goods_container.get_node("%s/item_total"%good).text = "TOTAL = 0"
