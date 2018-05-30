extends Control

const BANNER = "Anda hendak meminjam koin sebesar $%d dalam waktu %d hari harus kembali. Yakin ?"
const BANNER_E = "Anda masih punya hutang $%d! Jatuh tempo kurang %d hari"
var current_sken = "Awal"

func _ready():
	$dialog.hide()
	pass

func _on_btnKeluar_pressed():
	queue_free()
	get_tree().paused = false

var pinjam = {"harga":0,"day":0,"bisa":true}
func _on_opsi_pressed(nama):
	match nama:
		"opsi1":
			pinjam.harga = 1000
			pinjam.day = 5
		"opsi2":
			pinjam.harga = 1500
			pinjam.day = 10
		"opsi3":
			pinjam.harga = 2000
			pinjam.day = 15
	$dialog.show()
	$dialog/label.text = BANNER %[pinjam.harga, pinjam.day]

func _on_btnPilih_pressed():
	if pinjam.bisa:
		pinjam.bisa = false
		get_parent().game_data.bank = pinjam
		get_parent().game_data.money += pinjam.harga
	else:
		$dialog/label.text = BANNER_E %[get_parent().game_data.bank.harga,get_parent().game_data.bank.day]
		return
