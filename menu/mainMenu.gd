extends Control

@onready var buttons = $Buttons
# @onready var settings = $SettingsMenu
var settingsMenu = preload("res://menu/settingsMenu.tscn")
signal start_game

func _ready():
	AudioManager.play_music("menu.mp3")
	Camera.set_static()
	for child : Button in buttons.get_children():
		child.connect("pressed", handle_button.bind(child.name))

func handle_button(button_name):
	if(button_name == "Start"):
		Camera.transition.fade("Travel")
		queue_free()
	elif(button_name == "Settings"):
		add_child(settingsMenu.instantiate())