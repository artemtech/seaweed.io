extends Control
const BANNER_N = "Anda yakin untuk menjual %d %s dengan harga %d ?"
var gudang_data
var total = 0
var qty = 0
var nama_prod 

func _ready():
	$Notifikasi.get_close_button().connect("pressed",self,"reset_data_gudang")
	$Notifikasi.get_cancel().connect("pressed",self,"reset_data_gudang")
	gudang_data = get_parent().game_data.gudang
	for good in $TabContainer2/Gudang/ItemList/ItemContainer.get_children():
		get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/stok" % good.name).text  = str(gudang_data["%s"%good.name]["qty"])
		if get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s" % good.name).has_node("h_jual"):
			get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/h_jual" % good.name).text  = "HARGA = $%d" % gudang_data["%s"%good.name]["harga"]
			get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/qty" % good.name).set_max(gudang_data["%s"%good.name]["qty"])
			get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/qty" % good.name).connect("value_changed",self,"_on_qty_value_changed",[good.name])
			get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/BtnDoJual" % good.name).connect("pressed",self,"_on_BtnDoJual_pressed",[good.name])

func _on_qty_value_changed(value,nama):
	qty = get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/qty" % nama).get_value()
	total = gudang_data[nama]["harga"] * qty
	get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/total" % nama).text = "$ %d" %total
	pass

func _on_BtnDoJual_pressed(nama):
	nama_prod = nama
	$Notifikasi.dialog_text = BANNER_N %[qty,nama,total]
	$Notifikasi.show()
	pass

func _on_BtnKeluar_pressed():
	var data = get_gudang_data()
	get_parent().game_data["gudang"] = data
	queue_free()
	get_tree().paused = false

func _on_Notifikasi_confirmed():
	get_parent().game_data["gudang"][nama_prod]["qty"] -= qty
	get_parent().game_data["money"] += total
	reset_data_gudang()
	$Sukses.show()

func get_gudang_data():
	return gudang_data

func reset_data_gudang():
	gudang_data = get_parent().game_data["gudang"]
	get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/qty" % nama_prod).set_value(0)
	get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/total" % nama_prod).text = "$ 0"
	get_node("TabContainer2/Gudang/ItemList/ItemContainer/%s/stok" % nama_prod).text = str(gudang_data[nama_prod]["qty"])
	total = 0
	qty = 0
	nama_prod = ""
	pass