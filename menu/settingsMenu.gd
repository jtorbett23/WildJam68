extends Control

@onready var options = $Options

func _ready():
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
		self.visible = false
	elif(button_name == "Sound -"):
		print(button_name)
	elif(button_name == "Sound +"):
		print(button_name)
	elif(button_name == "Music -"):
		print(button_name)
	elif(button_name == "Music -"):
		print(button_name)
	