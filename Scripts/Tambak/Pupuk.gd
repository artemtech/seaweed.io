extends "res://Scripts/Tambak/Tools.gd"

enum list_pupuk {A,K,N,P,U}
export (list_pupuk) var tipe_pupuk

func _ready():
	print(list_pupuk)
	print("tipe tools: %d" % tipe_tools)
	print("tipe pupuk: %d" % tipe_pupuk)
	pass

