extends CharacterBody2D

@export var speed : int = 400

var interactable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("interact"):
		if(interactable):
			if(interactable.name == "Door"):
				position.x += 300
			elif(interactable.name == "Door2"):
				position.x -= 300

			print("interact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if Input.is_action_pressed("move_right"):
		# Move as long as the key/button is pressed.
		velocity.x = speed
	elif Input.is_action_pressed("move_left"):
		# Move as long as the key/button is pressed.
		velocity.x = -speed
	else:
		velocity.x = 0
	var collision = move_and_collide(velocity * delta)
	# if collision:
	# 	print("I collided with ", collision.get_collider().name)
