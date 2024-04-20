extends Area2D

@export var art_index : int = 1
@export var frame_index : int = 1


var canvas_info: Dictionary = {
	1 : {"size": Vector2(84,107), "pos": Vector2(-5,-3)},
	2 : {"size": Vector2(71, 71), "pos": Vector2(-4,-10)},
	3 : {"size": Vector2(72,72), "pos": Vector2.ZERO}
	
}

@onready var art : Sprite2D = $Art
@onready var frame : Sprite2D = $Frame
func _ready():
	
	var frame_path = "res://assets/art/frame-{0}.png".format({"0": str(frame_index)})
	frame.texture = load(frame_path)
	#check for the painting
	#is there a painting placed
	#is it the real or the forged
	var art_path = "res://assets/art/painting/painting-{0}.png".format({"0": str(art_index)})
	art.texture = load(art_path)
	art.position = canvas_info[frame_index]["pos"]
	art.scale = canvas_info[frame_index]["size"] / art.texture.get_size()

	pass
	#convert size of painting to canvas
