extends Node

var _current_screen = ""
var _daftar_player = []

var _player = {
	"name":"nganu",
	"company":"sae",
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

func get_player_with_name_and_company(var player):
	var data = FileManager.load_data(player)
	return data

func set_player(var player={}):
	_player = player

func get_player():
	return _player

func set_daftar_player(var lplayer = []):
	_daftar_player = lplayer

func get_all_player_lists():
	return _daftar_player