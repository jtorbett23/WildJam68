extends Camera2D

var target = null
var transition_ref = preload("res://transition.tscn")
var transition
var canvas 

func _ready():
	canvas = CanvasLayer.new()
	add_child(canvas)
	transition = transition_ref.instantiate()
	canvas.add_child(transition)

func set_follow(new_target):
	anchor_mode = Camera2D.ANCHOR_MODE_DRAG_CENTER
	target = new_target

func set_position_y(pos_y):
	position.y = pos_y + get_viewport().get_size().y / 2


func set_static():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	position = Vector2.ZERO
	target = null

func _process(_delta):
	if(target):
		position.x = target.position.x