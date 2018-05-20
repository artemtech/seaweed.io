extends Node

const BANNER = "Hello, %s from %s Corporation !"
onready var current_scene = "FirstScene"
onready var user_selected = false

onready var current_player = {
	"name":"user001",
	"company":"seaweed.io"
}

func _ready():
	$Konfirmasi.get_cancel().connect("pressed",self,"_on_Konfirmasi_cancel_pressed")
	$Konfirmasi.get_close_button().connect("pressed",self,"_on_Konfirmasi_cancel_pressed")
	$Konfirmasi.get_label().set_align(Label.ALIGN_CENTER)
	
	for node in get_children():
		var btn_cancel = node.find_node("BtnCancel",true,true)
		if btn_cancel != null:
			# connect with Back to Scene Awal function
			btn_cancel.connect("pressed",self,"_on_BtnCancel_pressed")
			pass
	# get all player list from saved files
	add_player_from_db()

func set_current_player(var player):
	user_selected = true
	current_player = Utils.get_player_with_name_and_company(player)
	$LoadScene/BtnContainer/CurrentUser.text = player[0] + "-" + player[1]
	pass

func reset_field():
	# reset all stored data
	user_selected = false
	Utils.set_player()
	Utils._daftar_player = []
	# reset user input on new game fields
	for field in $NewScene/BtnContainer.get_children():
		if field is LineEdit and not field.text.empty():
			field.text = ""
	# reset user lists on loadscene
	$LoadScene/BtnContainer/CurrentUser.text = "CLICK ON PROFILE ABOVE"
	for player in get_node("LoadScene/BtnContainer/UserContainer/UserLists").get_children():
		player.queue_free()
	# reload player data
	add_player_from_db()

func add_player_from_db():
	# logic retrieve data from db files
	FileManager.get_all_player()
	for player_name in Utils.get_all_player_lists():
		# buat tombol baru
		var btn = Button.new()
		# namanya diset: username - perusahaan
		btn.text = "%s - %s" %[player_name[0],player_name[1]]
		# kalo diklik jalanin method set_current_player
		btn.connect("pressed",self,"set_current_player",[player_name])
		# tambahin btn sebagai child node dari user lists
		get_node("LoadScene/BtnContainer/UserContainer/UserLists").add_child(btn)
	pass

func _on_BtnExit_pressed():
	# on button exit pressed 
	$Konfirmasi.dialog_text = "Are you sure to exit ?"
	$Konfirmasi.show()
	get_tree().paused = true
	current_scene = "DoExit"

func _on_Konfirmasi_cancel_pressed():
	get_tree().paused = false
	match current_scene:
		"DoExit":
			current_scene = "NewScene"
		"DoDelete":
			current_scene = "LoadScene"

func _on_Konfirmasi_confirmed():
	match current_scene:
		"DoExit":
			get_tree().quit()
		"DoDelete":
			get_tree().paused = false
			var player = [current_player.name,current_player.company]
			FileManager.delete_data(player)
			reset_field()
			current_scene = "LoadScene"
			pass

func _on_BtnPlay_pressed():
	#check! where are we on now?
	match current_scene:
		"NewScene":
			# kalo user dan kompany sudah ada, tolak!
			if is_user_data_exist():
				$Notifikasi.dialog_text = "This profile is exist!"
				$Notifikasi.show()
				return
			current_player.name = $NewScene/BtnContainer/TxtUname.text
			current_player.company = $NewScene/BtnContainer/TxtComp.text
			FileManager.save_data(current_player)
			pass
		"LoadScene":
			# kalau usernya ndak dipilih, keluarin popup !
			if not user_selected:
				$Notifikasi.dialog_text = "Please, select 1 profile above to load game data!"
				$Notifikasi.show()
				return
	get_node(current_scene).hide()
	Utils.set_player(current_player)
	$"MainScene/Username Panel/username_main_label".text = BANNER % [current_player.name,current_player.company]
	$MainScene.show()
	current_scene = "MainScene"

func is_user_data_exist():
	#TODO 1. cek username 2. cek perusahaan
	var our_data = [$NewScene/BtnContainer/TxtUname.text, $NewScene/BtnContainer/TxtComp.text]
	if our_data in Utils.get_all_player_lists():
		return true

func _on_BtnHelp_pressed():
	$MainScene.hide()
	$HelpScene.show()
	current_scene = "HelpScene"

func _on_BtnCancel_pressed():
#	print("scene saat ini: "+current_scene)
	get_node(current_scene).hide()
	match current_scene:
		"HelpScene":
			current_scene = "MainScene"
		_:
			current_scene = "FirstScene"
#	print("after cancel "+current_scene)
	reset_field()
	get_node(current_scene).show()

func _on_BtnNewGame_pressed():
	$FirstScene.hide()
	$NewScene.show()
	reset_field()
	current_scene = "NewScene"

func _on_BtnLoadGame_pressed():
	$FirstScene.hide()
	$LoadScene.show()
	current_scene = "LoadScene"

func _on_BtnPlayGame_pressed():
	Transition.fade_to("res://Scenes/InGameScene.tscn")

func _on_BtnDelete_pressed():
	if user_selected:
		get_tree().paused = true
		current_scene = "DoDelete"
		$Konfirmasi.dialog_text = "Are you sure to delete %s-%s ?" %[current_player.name,current_player.company]
		$Konfirmasi.show()
	else:
		$Notifikasi.dialog_text = "Choose user first!"
		$Notifikasi.show()
		pass
	pass