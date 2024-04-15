extends Node2D

var image_path_1 ="res://assets/user-art/Canvas-Screenshot-2024-04-13T22:13:56.png"
var image_path_2 = "res://assets/user-art/Canvas-Screenshot-2024-04-14T23:36:24.png"
var image_path_3 = "res://assets/user-art/Canvas-Screenshot-2024-04-14T23:36:53.png"
# Called when the node enters the scene tree for the first time.
func _ready():
	var image: Image = Image.new()
	image.load(image_path_1)
	var image2: Image = Image.new()
	image2.load(image_path_2)
	var image3: Image = Image.new()
	image3.load(image_path_3)
	# var image2 : Image = sprite2.texture.get_image()
	# var image3 : Image = sprite3.texture.get_image()
	print("Image 1 with 2")
	print(image.compute_image_metrics(image2, false))
	print("Image 1 with 2: with luma")
	print(image.compute_image_metrics(image2, true))
	print("Image 1 with 3")
	print(image.compute_image_metrics(image3, false))
	print("Image 1 with 3: with luma")
	print(image.compute_image_metrics(image3, true))
	print("Image 3 with 1")
	print(image3.compute_image_metrics(image, false))
	print("Image 3 with 1: with luma")
	print(image3.compute_image_metrics(image, true))
	print("Image 2 with 3")
	print(image2.compute_image_metrics(image3, false))
	print("Image 2 with 3: with luma")
	print(image2.compute_image_metrics(image3, true))
	print("Image 3 with 3")
	print(image3.compute_image_metrics(image3, false))
	print("Image 3 with 3: with luma")
	print(image3.compute_image_metrics(image3, true))
	pass # Replace with function body.
	
#Take screenshoot image
func take_pic(filename=""):
	var capture = get_viewport().get_texture().get_image()
	var _time = Time.get_datetime_string_from_system()

	var filepath = "./assets/user-art/{1}-Screenshot-{0}.png".format({"0": _time, "1":filename})
	capture.save_png(filepath)
