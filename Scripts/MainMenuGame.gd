extends Node

const BANNER = "Hello, "
onready var current_scene = "FirstScene"

onready var current_player = {
	"name":"user001",
	"company":"seaweed.io",
	"money":100
}

func _ready():
	FileManager.get_all_player()
	$PopupExit.get_cancel().connect("pressed",self,"_onPopupExit_cancel_pressed")
	$PopupExit.get_close_button().connect("pressed",self,"_onPopupExit_cancel_pressed")
	$PopupExit.get_label().set_align(Label.ALIGN_CENTER)
	
	for node in get_children():
		var btn_cancel = node.find_node("BtnCancel",true,true)
		if btn_cancel != null:
			# connect with Back to Scene Awal function
			btn_cancel.connect("pressed",self,"_on_BtnCancel_pressed")
			pass

func reset_field():
	# reset user input on new game fields
	for field in $NewScene/BtnContainer.get_children():
		if field is LineEdit and not field.text.empty():
			field.text = ""
			pass
		pass
	pass
	
func add_player_from_db(var usrlist=[]):
	# TODO logic retrieve data from db files
	pass

func _on_BtnExit_pressed():
	# on button exit pressed 
	$PopupExit.show()
	get_tree().paused = true

func _onPopupExit_cancel_pressed():
	get_tree().paused = false

func _on_PopupExit_confirmed():
	get_tree().quit()

func _on_BtnPlay_pressed():
	#check! where are we on now?
	match current_scene:
		"NewScene":
			# TODO some new game logic
			current_player.name = $NewScene/BtnContainer/TxtUname.text
			current_player.company = $NewScene/BtnContainer/TxtComp.text
			FileManager.save_data(current_player.name,current_player)
			pass
		"LoadScene":
			# TODO load "NewScene/BtnContainer/LblComp"game logic from user list,
			pass
	get_node(current_scene).hide()
	Utils.set_player(current_player)
	$"MainScene/Username Panel/username_main_label".text = BANNER + Utils._player.name
	$MainScene.show()
	current_scene = "MainScene"

func _validasi_data():
	#TODO 1. cek username 2. cek perusahaan
#	if $NewScene/BtnContainer/TxtUname.text == data_db and $NewScene/BtnContainer/TxtComp.text == data_db:
#		$NewScene/PopUp.dialog_text = "Username dan perusahaan sudah digunakan!"
#	elif $NewScene/BtnContainer/TxtUname.text == data_db and $NewScene/BtnContainer/TxtComp.text != data_db:
#		$NewScene/PopUp.dialog_text = "Username sudah digunakan!"
#	elif $NewScene/BtnContainer/TxtUname.text != data_db and $NewScene/BtnContainer/TxtComp.text == data_db:
#		$NewScene/PopUp.dialog_text = "Perusahaan sudah digunakan!"
#	$NewScene/PopUp.show()
	pass

func _on_BtnHelp_pressed():
	$MainScene.hide()
	$HelpScene.show()
	current_scene = "HelpScene"

func _on_BtnCancel_pressed():
	print("scene saat ini: "+current_scene)
	get_node(current_scene).hide()
	match current_scene:
		"HelpScene":
			current_scene = "MainScene"
		_:
			current_scene = "FirstScene"
	print("after cancel "+current_scene)
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
