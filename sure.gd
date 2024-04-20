extends ColorRect

@onready var yes_button = $Sizer/Yes
@onready var no_button = $Sizer/No
@onready var question = $Sizer/Question
@onready var info = $Sizer/Info

var topic = null
signal response(response_choice, topic)

func _ready():
	no_button.connect("pressed", handle_response.bind("no"))
	yes_button.connect("pressed", handle_response.bind("yes"))


func setup(action, info_text):
	var question_text = "Are you sure you want to {0}".format({"0": action})
	question.text = question_text
	info.text = info_text
	topic = action

func handle_response(choice):
	self.hide()
	response.emit(choice, topic)
	topic = null	



