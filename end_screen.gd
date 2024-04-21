extends Control

@onready var return_button = $Return

@onready var text_label = $EndingText

func _ready():
	AudioManager.play_music("daytime.mp3")
	Camera.set_static()
	return_button.connect("pressed", handle_return)
	var text = "
	Thank you for playing.\n
	You earned £{0}
	".format({"0": GameData.money})
	text_label.text = text
	print(GameData.get_dict("Paintings"))


func handle_return():
	Camera.transition.fade("Main")
	queue_free()
