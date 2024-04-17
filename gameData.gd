extends Node

var settings : Dictionary = {
	"music_level": 50,
	"sound_level": 50
}

func set_value(key, value) -> void:
	if(key in settings.keys()):
		settings[key] = value

func get_value(key):
	if(key in settings.keys()):
		return settings[key]
