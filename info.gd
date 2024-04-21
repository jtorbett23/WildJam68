extends ColorRect

@onready var ok_button = $Ok
@onready var info = $Info

signal response_ok

func _ready():
	ok_button.connect("pressed", handle_response)


func setup(info_text):
	info.text = info_text
	self.visible = true

func handle_response():
	self.hide()
	response_ok.emit()



