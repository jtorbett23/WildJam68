extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var capture = get_viewport().get_texture().get_image()
	var _time = Time.get_date_dict_from_system()
	var filename = "./Test.png"
	capture.save_png(filename)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
