extends Control

@onready var exit_button = $Exit
func _ready():
	Camera.set_static()
	exit_button.connect("pressed", exit_draw)

func exit_draw():
	Camera.transition.fade("Travel")
	queue_free()