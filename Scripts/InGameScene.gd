extends Control

enum HASIL {NOTHING,S,M,L}
enum STATUS {LOCKED,UNLOCKED}
enum GAME_STATE {NEW,LOAD,PAUSED,GAMEOVER}

signal gamedata_changed

onready var tokocontrol = load("res://Scenes/GameObjects/TokoControl.tscn")
onready var konsumencontrol = load("res://Scenes/GameObjects/KonsumenControl.tscn")
onready var bankcontrol = load("res://Scenes/GameObjects/BankControl.tscn")
onready var pabrikcontrol = load("res://Scenes/GameObjects/PabrikControl.tscn")
onready var tambakcontrol = load("res://Scenes/GameObjects/TambakControl.tscn")

var game_data = {
	"money" : 5000,
	"time" : "00:00:00",
	"day" : 0,
	"reputasi" : 200,
	"game_state" : NEW,
	"pabrik" : {
		"m_kering" : {
			"status" : LOCKED,
			"harga" : 3000,
			"on_production" : false,
			"time_remaining" : -1,
			"hasil" : NOTHING
		},
		"m_tepung" : {
			"status" : LOCKED,
			"harga" : 4000,
			"on_production" : false,
			"time_remaining" : -1,
			"hasil" : NOTHING
		},
		"m_agar2" : {
			"status" : LOCKED,
			"harga" : 7500,
			"on_production" : false,
			"time_remaining" : -1,
			"hasil" : NOTHING
		},
	},
	"tambak" : {
		"petak1": {
			"time_remaining" : 10,
			"on_production" : true,
			"actions" : [],
			"hasil" : NOTHING
		},
		"petak2": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : NOTHING
		},
		"petak3": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : NOTHING
		},
		"petak4": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : NOTHING
		},
		"petak5": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : NOTHING
		},
		"petak6": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : NOTHING
		}
	},
	"bank" : {
		"hutang" : {
			"status" : true,
			"nominal" : 5000,
			"tempo" : 10*24*3600
		}
	},
	"konsumen" : {
		"namanya" : {
			"asal" : "malang",
			"permintaan" : "rl_kering",
			"qty" : 30,
			"tempo" : 2,
			"time_remaining" : 0,
			"harga_satuan" : 20,
			"reputasi" : 200
		}
	},
	"gudang" : {
		"bibit" : {
			"qty" : 10,
		},
		"rl_basah_s" : {
			"qty" : 0,
		},
		"rl_basah_m" : {
			"qty" : 0,
		},
		"rl_basah_l" : {
			"qty" : 0,
		},
		"rl_kering_s" : {
			"qty" : 0,
			"harga" : 525
		},
		"rl_kering_m" : {
			"qty" : 0,
			"harga" : 550
		},
		"rl_kering_l" : {
			"qty" : 0,
			"harga" : 580
		},
		"tepung_s" : {
			"qty" : 0,
			"harga" : 1000
		},
		"tepung_m" : {
			"qty" : 0,
			"harga" : 1200
		},
		"tepung_l" : {
			"qty" : 0,
			"harga" : 1350
		},
		"agar2_s" : {
			"qty" : 0,
			"harga" : 1500
		},
		"agar2_m" : {
			"qty" : 0,
			"harga" : 1850
		},
		"agar2_l" : {
			"qty" : 0,
			"harga" : 2000
		},
		"gula" : {
			"qty" : 0,
		},
		"garam" : {
			"qty" : 0,
		},
		"metil_alkohol" : {
			"qty" : 0,
		},
		"pewarna" : {
			"qty" : 0,
		},
		"perasa" : {
			"qty" : 0,
		}
	},
}

func _ready():
	if Utils.get_player().has("game_state"):
		game_data = Utils.get_player()
		pass
	else:
		game_data["name"] = Utils.get_player().name
		game_data["company"] = Utils.get_player().company
	pass

func _on_Toko_pressed():
	if not has_node("TokoControl"):
			var child = tokocontrol.instance()
			add_child(child)
			get_node("TokoControl").show()

func _on_Konsumen_pressed():
	if not has_node("KonsumenControl"):
			var child = konsumencontrol.instance()
			add_child(child)
			get_node("KonsumenControl").show()

func _on_Bank_pressed():
	if not has_node("BankControl"):
			var child = bankcontrol.instance()
			add_child(child)
			get_node("BankControl").show()

func _on_Pabrik_pressed():
	if not has_node("PabrikControl"):
			var child = pabrikcontrol.instance()
			add_child(child)
			get_node("PabrikControl").show()

func _on_Tambak_pressed():
	if not has_node("TambakControl"):
			var child = tambakcontrol.instance()
			add_child(child)
			get_node("TambakControl").show()