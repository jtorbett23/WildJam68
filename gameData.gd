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

var draw_data : Dictionary = {
	1 : [],
	2 : [],
	3 : [],
	4 : [],
	5 : [],
	6 : [],
	7 : [],
	8 : [],
}

func set_value(dict_name, key, value) -> void:
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
	elif(dict_name == "Draw"):
		if(key in draw_data.keys()):
			return draw_data[key]

func get_dict(dict_name):
	if(dict_name == "Settings"):
		return settings
	elif(dict_name == "Paintings"):
		return paintings
	elif(dict_name == "Draw"):
		return draw_data

func set_dict(dict_name, dict):
	if(dict_name == "Settings"):
		settings = dict
	elif(dict_name == "Paintings"):
		paintings = dict
	elif(dict_name == "Draw"):
		draw_data = dict
	

