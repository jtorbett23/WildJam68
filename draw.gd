extends Node2D

var color = Color(255, 255, 255, 1)
var radius = 0


func _draw():
	if Input.is_action_pressed("draw"):
		RenderingServer.viewport_set_clear_mode(get_viewport().get_viewport_rid(), RenderingServer.VIEWPORT_CLEAR_NEVER)
		radius = 20
	if Input.is_action_just_released("draw"):
		radius = 0.0


	draw_circle(Vector2.ZERO, radius, color)

# Called when the node enters the scene tree for the first time.
func _ready():



	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()
	queue_redraw()
	pass
