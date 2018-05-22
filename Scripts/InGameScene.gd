extends Node2D

enum HASIL {NOTHING,S,M,L}

var game_data = {
	"money" : 0,
	"time" : "00:00:00",
	"day" : 0,
	"pabrik" : {
		"reputasi" : 200
	},
	"tambak" : {
		"petak1": {
			"time_remaining" : 10,
			"on_production" : true,
			"actions" : [],
			"hasil" : HASIL.NOTHING
		},
		"petak2": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : HASIL.NOTHING
		},
		"petak3": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : HASIL.NOTHING
		},
		"petak4": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : HASIL.NOTHING
		},
		"petak5": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : HASIL.NOTHING
		},
		"petak6": {
			"time_remaining" : -1,
			"on_production" : false,
			"actions" : [],
			"hasil" : HASIL.NOTHING
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
	"toko" : {
		"bibit_rumput_laut" : 500,
		"gula" : 25,
		"garam" : 25,
		"metil_alkohol" : 25,
		"pewarna" : 25,
		"perasa" : 25,
	},
	"gudang" : {
		"bibit_rumput_laut" : {
			"qty" : 0,
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
		"pewarna_makanan" : {
			"qty" : 0,
		},
		"perasa_buah" : {
			"qty" : 0,
		}
	},
}
