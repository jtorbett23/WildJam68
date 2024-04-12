extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





#Take screenshoot image
func take_pic(filename=""):
	var capture = get_viewport().get_texture().get_image()
	var _time = Time.get_datetime_string_from_system()

	var filepath = "./assets/user-art/{1}-Screenshot-{0}.png".format({"0": _time, "1":filename})
	capture.save_png(filepath)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("screenshot"):
		take_pic("Input")
	elif Input.is_action_just_pressed("clear"):
		RenderingServer.viewport_set_clear_mode(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_CLEAR_ALWAYS)


