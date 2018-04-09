# script Player - inherit to Node Class
extends Node

class Player:
	# attributes
	var _nama
	var _poin
	# dictionary for storing our needs
	var _inventaris
	
	# constructor
	func _init(var nama="player", var poin=0):
		self._nama = nama
		self._poin = poin
		self._inventaris = {}
		
	# getter and setter
	func get_nama():
		return self._nama

	func get_poin():
		return self._poin

	func get_inventaris():
		return self._inventaris

	func set_nama(var nama = "player"):
		self._nama = nama

	func set_poin(var poin):
		self._poin = poin

	# add new inventory
	func add_inventory(key, value):
		self._inventaris.key = value
		
	func get_inventory(key):
		return self._inventaris.key