extends Node

var file = null

# fungsi save game
func save_data(player, var data={}):
	var nama = player
	var save_path = "user://%s.dat" % nama
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("persistent_data")
#	save_dict[nama] = {}
	for keys in data:
#		save_dict["%s" % nama][keys] = data[keys]
		save_dict[keys] = data[keys]
		pass
	print(save_dict)
	_data_writer(save_path,to_json(save_dict))
	pass

# fungsi load game
func load_data(player):
	var save_data = "user://%s.dat" % player
	var loaded_data = _data_reader(save_data)
	if loaded_data != null:
		Utils.set_player(loaded_data)
		pass
	return 
	pass

# ketika kita temukan semua nama file dalam folder, 
# masukkan ke array, lalu return sebagai array 2D, berisi:
#	nama - company
func get_all_player():
	var files = []
	var dir = Directory.new()
	dir.open("user://")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			file = "user://%s" % file
			files.append([_data_reader(file).name,_data_reader(file).company])
	dir.list_dir_end()
	print(files)
	Utils.set_daftar_player(files)

func delete_data(player):
	pass

# fungsi tulis file
func _data_writer(file_name, data):
	file = File.new()
	file.open(file_name, File.WRITE)
	file.store_line(data)
	file.close()
	pass

# fungsi baca file
func _data_reader(file_name):
	file = File.new()
	if not file.file_exists(file_name):
		print ("Unable to open save file: %s" % file_name)
		return
	file.open(file_name,File.READ)
	var currentLine = {}
	currentLine = parse_json(file.get_as_text())
	file.close()
	return currentLine