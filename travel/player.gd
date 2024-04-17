extends Sprite2D

@export var speed : int = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("interact"):
		print("interact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_pressed("move_right"):
		# Move as long as the key/button is pressed.
		position.x += speed * delta
	elif Input.is_action_pressed("move_left"):
		# Move as long as the key/button is pressed.
		position.x -= speed * delta
