extends Control

@onready var buttons_menu = $Menu/Buttons
@onready var button_continue = $Instructions/Continue
# @onready var settings = $SettingsMenu
var settingsMenu = preload("res://menu/settingsMenu.tscn")
signal start_game

func _ready():
	GameData.reset_state()
	AudioManager.play_music("menu.mp3")
	Camera.set_static()
	for child : Button in buttons_menu.get_children():
		child.connect("pressed", handle_button.bind(child.name))
	button_continue.connect("pressed", handle_button.bind(button_continue.name))

func handle_button(button_name):
	if(button_name == "Start"):
		$Menu.hide()
		$Instructions.show()
	elif(button_name == "Settings"):
		add_child(settingsMenu.instantiate())
	if(button_name == "Continue"):
		Camera.transition.fade("Travel")
		queue_free()