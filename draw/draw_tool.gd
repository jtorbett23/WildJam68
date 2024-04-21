extends Control

@onready var exit_button = $Exit
@onready var drawer = $SubViewportContainer/SubViewport/Draw
@onready var sure = $Sure
func _ready():
	sure.connect("response", handle_response)
	Camera.set_static()
	exit_button.connect("pressed", exit_draw)

func exit_draw():
	sure.setup("exit drawing", "Current forgeries will be avaliable to place. You can return to edit later", null)

func handle_response(choice, topic, target):
	if(topic == "exit drawing"):
		if(choice == "yes"):
			drawer.save_draw_data()
			drawer.print_forgery()
			Camera.transition.fade("Travel")
			queue_free()
