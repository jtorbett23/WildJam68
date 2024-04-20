extends Node2D

var colour = Color.BLACK	
var radius = 20

var draw_data : Array = []
var previous_draw : Array = [[]]
var min_pos : Vector2
var max_pos : Vector2
var canvas_size = Vector2(500,500)

@onready var colours : Node2D = $"../../../Colours"
@onready var sizes : Node2D = $"../../../Sizes"


@onready var subviewport : SubViewport = $"../."
@onready var subviewport_container : SubViewportContainer = $"../../."
@onready var background : Sprite2D = $"Background"
# @onready var ref_background : Sprite2D =  $"../../../RefBackground"
@onready var reference : Sprite2D = $"../../../Reference"

func _draw():
	for data in draw_data:
		draw_circle(data.pos, data.radius, data.colour)

func get_avaliable_paintings():
	var paintings = GameData.get_dict("Paintings")
	var available_paintings = {}
	for key in paintings.keys():
		if(paintings[key]["is_placed"] == false):
			available_paintings[key] = paintings[key]
	return available_paintings



# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play_music("drawing.mp3")
	for child : Button in colours.get_children():
		child.connect("pressed", change_colour.bind(child.name))
	
	for child : Button in sizes.get_children():
		child.connect("pressed", change_size.bind(child.name))
	var paintings = get_avaliable_paintings()
	if(paintings.size() == 0):
		pass
	# else:
	var bg_img_size = background.texture.get_image().get_size()
	var ref_img_size = reference.texture.get_image().get_size()
	print(ref_img_size, bg_img_size)
	var scale_x : float = float(ref_img_size.x) / float(bg_img_size.x)
	var scale_y : float = float(ref_img_size.y) / float(bg_img_size.y)
	# var scale_x : float = float(canvas_size.x) / float(bg_img_size.x)
	# var scale_y : float = float(canvas_size.y) / float(bg_img_size.y)
	# var scale_ref_x : float = float(canvas_size.x) / float(ref_img_size.x)
	# var scale_ref_y : float = float(canvas_size.y) / float(ref_img_size.y)
	background.scale = Vector2(scale_x, scale_y)
	# reference.scale = Vector2(scale_ref_x, scale_ref_y)
	# ref_background.scale = Vector2(scale_x, scale_y)
	subviewport_container.size = background.get_rect().size * background.transform.get_scale()
	var background_size = background.get_rect().size * background.transform.get_scale()
	min_pos = background.global_position
	max_pos = min_pos + background_size

func change_colour(_colour_name):
	AudioManager.play_sound("droplet.mp3")
	if _colour_name == "Black":
		colour = Color.BLACK
	elif _colour_name == "White":
		colour = Color.WHITE

func change_size(_radius_size):
	AudioManager.play_sound("brush.mp3")
	if _radius_size == "Small":
		radius = 10
	elif _radius_size == "Medium":
		radius = 20
	elif _radius_size == "Big":
		radius = 40

func is_on_canvas(mouse_pos) -> bool:
	#within min
	if (mouse_pos.x > min_pos.x) and (mouse_pos.y > min_pos.y):
		#within max
		if (mouse_pos.x < max_pos.x) and (mouse_pos.y < max_pos.y):
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos = get_global_mouse_position()
	if Input.is_action_pressed("draw") and is_on_canvas(pos):
		var draw_event = {"pos":pos, "radius": radius, "colour": colour}
		if(draw_data.find(draw_event) == -1):
			draw_data.append(draw_event)
			#undo v2
			previous_draw.append(draw_data.duplicate())
	elif Input.is_action_just_pressed("clear"):
		draw_data = []
		#undo v2
		previous_draw.append([])
	elif Input.is_action_pressed("undo"):
		#undo v2
		if(previous_draw.size() > 0):
			var prev = previous_draw.pop_back()
			draw_data = prev
		elif(previous_draw.size() == 0):
			previous_draw = [[]]
	# if Input.is_action_just_pressed("screenshot"):
	# 	print("click wow")
	# 	take_pic("Canvas")
	if Input.is_action_just_pressed("compare"):
		compare_with_reference()	
	queue_redraw()


func take_pic(filename=""):
	# background.visible = false
	# await RenderingServer.frame_post_draw
	var capture : Image = subviewport.get_texture().get_image()
	# background.visible = true
	var _time = Time.get_datetime_string_from_system()
	var filepath = "./assets/user-art/{1}-Screenshot-{0}.png".format({"0": _time, "1":filename})

	capture.save_png(filepath)
	# subviewport.size = original_size

func compare_with_reference():
	var ref_img : Image = reference.texture.get_image()
	# background.visible = false
	# await RenderingServer.frame_post_draw
	# 15 seems an ok value for peak_snr with luma / 10 without
	var drawing : Image = subviewport.get_texture().get_image()
	# background.visible = true
	# print(ref_img.get_size(), drawing.get_size())
	compare_images(ref_img, drawing)
	# ref_img.save_png("./test1.png")
	# drawing.save_png("./test2.png")

	


func compare_images(image1, image2):
	print("Image 1 with 2")
	print(image1.compute_image_metrics(image2, false))
	print("Image 1 with 2: with luma")
	print(image1.compute_image_metrics(image2, true))

