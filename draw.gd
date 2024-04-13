extends Node2D

var colour = Color.BLACK	
var radius = 20

var draw_data : Array = []
var previous_draw : Array = [[]]
var min_pos : Vector2
var max_pos : Vector2

@onready var colours : Node2D = $"../../../Colours"
@onready var sizes : Node2D = $"../../../Sizes"


@onready var subviewport : SubViewport = $"../."
@onready var subviewport_container : SubViewportContainer = $"../../."

func _draw():
	for data in draw_data:
		draw_circle(data.pos, data.radius, data.colour)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child : Button in colours.get_children():
		child.connect("pressed", change_colour.bind(child.name))
	
	for child : Button in sizes.get_children():
		child.connect("pressed", change_size.bind(child.name))

	var background : Sprite2D = $"Background"
	subviewport_container.size = background.get_rect().size * background.transform.get_scale()
	var background_size = background.get_rect().size * background.transform.get_scale()
	min_pos = background.global_position
	max_pos = min_pos + background_size
	print(min_pos, max_pos)

	pass # Replace with function body.

func change_colour(_colour_name):
	if _colour_name == "Black":
		colour = Color.BLACK
	elif _colour_name == "Pink":
		colour = Color.PINK
	elif _colour_name == "Blue":
		colour = Color.BLUE

func change_size(_radius_size):
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
		#undo v1
		# draw_data.pop_back()
	if Input.is_action_just_pressed("screenshot"):
		print("click wow")
		take_pic("Canvas")	
	queue_redraw()


func take_pic(filename=""):
	var capture = subviewport.get_texture().get_image()
	var _time = Time.get_datetime_string_from_system()

	var filepath = "./assets/user-art/{1}-Screenshot-{0}.png".format({"0": _time, "1":filename})
	capture.save_png(filepath)
	# subviewport.size = original_size
