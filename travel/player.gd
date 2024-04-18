extends CharacterBody2D

@export var speed : int = 400
var interactable = false
var settingsMenu = preload("res://menu/settingsMenu.tscn")
var enabled : bool = false

func _input(event):
	if event.is_action_pressed("interact"):
		# $CanvasLayer.add_child(settingsMenu.instantiate())
		if(interactable):
			if(interactable.name == "Door"):
				Camera.transition.fade(Vector2(position.x+ 300, position.y))
			elif(interactable.name == "Door2"):
				Camera.transition.fade(Vector2(position.x - 300, position.y))
			print("interact")

func _physics_process(delta):
	if(enabled):
		if Input.is_action_pressed("move_right"):
			# Move as long as the key/button is pressed.
			velocity.x = speed
		elif Input.is_action_pressed("move_left"):
			# Move as long as the key/button is pressed.
			velocity.x = -speed
		else:
			velocity.x = 0
		move_and_collide(velocity * delta)

