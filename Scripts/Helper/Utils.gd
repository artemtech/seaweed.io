extends Node

var _current_screen = ""
var _daftar_player = []

var _player = {
	"name":"nganu",
	"company":"sae",
	"uang":100
}

func find_node_with_group(group, recursive=true):
	for child in get_children():
		if child.is_in_group(group):
			return child
		if recursive:
			var node = child.find_node_with_group(group,true)
			if node != null:
				return node
	pass

func set_player(var player={}):
	_player = player

func set_daftar_player(var lplayer = []):
	_daftar_player = lplayer