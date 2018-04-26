extends Control

export var konten1 = {
	"gambar":"res://Asset/1.png",
	"judul":"sabun",
	"harga":100,
	"status":true,
	"qty":0
}

func _on_BtnTutup_pressed():
	get_tree().paused = false
	self.queue_free()
