extends Control

@onready var buttons = $Buttons
@onready var settings = $SettingsMenu

func _ready():
	AudioManager.play_music("menu.mp3")
	for child : Button in buttons.get_children():
		child.connect("pressed", handle_button.bind(child.name))

func handle_button(button_name):
	if(button_name == "Start"):
		print("Start")
		pass
	elif(button_name == "Settings"):
		settings.visible = true
		pass