# script GameObjects - inherit to Node Class
extends Area2D

export var nama = "Objek1"
export var nyawa = 100
export var harga = 10
export var gambar = "res://Assets/GameObjects/ini toko.png"

func _ready():
	$Sprite.set_texture(load(gambar))