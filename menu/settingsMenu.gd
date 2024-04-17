extends Control

@onready var options = $Options
@onready var music_level_label = $Options/Music/Level
@onready var sound_level_label = $Options/Sound/Level


func _ready():
	music_level_label.text = str(GameData.get_value("music_level"))
	sound_level_label.text = str(GameData.get_value("sound_level"))
	for button in find_buttons(options):
		button.connect("pressed", handle_button.bind(button.name))

func find_buttons(parent):
	var buttons : Array= []
	for child in parent.get_children():
		if(child.get_class() == "Button"):
			buttons.append(child)
		elif child.get_child_count() > 0:
			buttons += find_buttons(child)
	return buttons

func handle_button(button_name):
	if(button_name == "Return"):
		queue_free()
	elif(button_name == "Sound +"):
		if(float(sound_level_label.text) <= 95):
			change_volume("Sound", 5)
	elif(button_name == "Sound -"):
		if(float(sound_level_label.text) >= 5):
			change_volume("Sound", -5)
	elif(button_name == "Music +"):
		if(float(music_level_label.text) <= 95):
			change_volume("Music", 5)
	elif(button_name == "Music -"):
		if(float(music_level_label.text) >= 5):
			change_volume("Music", -5)
	
func change_volume(player, change):
	
	var level
	if(player == "Music"):
		level = float(music_level_label.text)
		level += change
		music_level_label.text = str(level)
		GameData.set_value("music_level", level)
		AudioManager.change_music_volume(level)
	elif(player == "Sound"):
		level = float(sound_level_label.text)
		level += change
		sound_level_label.text = str(level)
		GameData.set_value("sound_level", level)
		AudioManager.change_sound_volume(level)
	