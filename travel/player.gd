extends CharacterBody2D

@export var speed : int = 400
var interactable = false

func _input(event):
	if event.is_action_pressed("interact"):
		if(interactable):
			if(interactable.name == "Door"):
				position.x += 300
			elif(interactable.name == "Door2"):
				position.x -= 300
			print("interact")

func _physics_process(delta):
	
	if Input.is_action_pressed("move_right"):
		# Move as long as the key/button is pressed.
		velocity.x = speed
	elif Input.is_action_pressed("move_left"):
		# Move as long as the key/button is pressed.
		velocity.x = -speed
	else:
		velocity.x = 0
	move_and_collide(velocity * delta)

