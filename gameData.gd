extends Node

var settings : Dictionary = {
	"music_level": 50,
	"sound_level": 50
}

var paintings : Dictionary = {
	1 : {"is_placed": true, "is_forged": false},
	2 : {"is_placed": true, "is_forged": false},
	3 : {"is_placed": true, "is_forged": false},
	4 : {"is_placed": true, "is_forged": false},
	5 : {"is_placed": true, "is_forged": false},
	6 : {"is_placed": true, "is_forged": false},
	7 : {"is_placed": true, "is_forged": false},
	8 : {"is_placed": true, "is_forged": false},
}

func set__value(dict_name, key, value) -> void:
	if(dict_name == "Settings"):
		if(key in settings.keys()):
			settings[key] = value
	elif(dict_name == "Paintings"):
		if(key in paintings.keys()):
			paintings[key] = value

func get_value(dict_name, key):
	if(dict_name == "Settings"):
		if(key in settings.keys()):
			return settings[key]
	elif(dict_name == "Paintings"):
		if(key in paintings.keys()):
			return paintings[key]

