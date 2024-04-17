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

func set_static():
	anchor_mode = Camera2D.ANCHOR_MODE_FIXED_TOP_LEFT
	target = null

func _process(_delta):
	if(target):
		position = target.position


