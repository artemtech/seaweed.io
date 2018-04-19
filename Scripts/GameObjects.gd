# script GameObjects - inherit to Node Class
extends Sprite

export var nama = "Objek1"
export var nyawa = 100
export var harga = 10
export var gambar = "res://Assets/GameObjects/obj1.png"

# made inner class
class GameObject:
	# attributes
	var _nama
	var _nyawa
	var _harga
	var _gambar
	
	# constructor
	func _init(nama,nyawa,harga,gambar):
		self._nama = nama
		self._nyawa = nyawa
		self._harga = harga
		self._gambar = gambar
		pass
	
	func get_nyawa():
		return self._nyawa
	
	func get_harga():
		return self._harga
	
	func get_nama():
		return self._nama
		
func _ready():
	self.set_texture(Texture.take_over_path(gambar))