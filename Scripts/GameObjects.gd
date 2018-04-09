# script GameObjects - inherit to Node Class
extends Node

export var nama = "Objek1"
export var nyawa = 100
export var harga = 10

# made inner class
class GameObject:
	# attributes
	var _nama
	var _nyawa
	var _harga
	
	# constructor
	func _init(nama,nyawa,harga):
		self._nama = nama
		self._nyawa = nyawa
		self._harga = harga
		pass
	
	func get_nyawa():
		return self._nyawa
	
	func get_harga():
		return self._harga
	
	func get_nama():
		return self._nama

func _ready():
	var kapas = GameObject.new(nama,nyawa,harga)
	print(kapas.get_nama())
	print(kapas.get_nyawa())
	print(kapas.get_harga())