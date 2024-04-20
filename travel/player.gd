extends CharacterBody2D

@export var speed : int = 600
var interactable = false
var settingsMenu = preload("res://menu/settingsMenu.tscn")
var enabled : bool = true #CHANGE BACK
@onready var travel_scene = $"../"
var height_change = 40

@onready var sprite = $Sprite2D


func _input(event):
	if event.is_action_pressed("interact"):
		# $CanvasLayer.add_child(settingsMenu.instantiate())
		if(interactable):
			if(interactable.name == "Office-Exit"):
				Camera.transition.fade(Vector2(interactable.target.position.x, position.y - height_change))
			elif(interactable.name == "Office-Enter"):
				Camera.transition.fade(Vector2(interactable.target.position.x, position.y + height_change))
			elif(interactable.name == "Exit"):
				print("Exit Hall")
			elif("Painting" in interactable.name):
				print(interactable.name)
			elif(interactable.name == "Computer"):
				Camera.target = null
				Camera.transition.fade("Draw")
				travel_scene.free()

var rotate_time = 0.35
var rotate_timer = 0
var rotate_value = 15

func _physics_process(delta):
	if(enabled):
		if Input.is_action_pressed("move_right"):
			# Move as long as the key/button is pressed.
			velocity.x = speed
			sprite.flip_h = false
			$CollisionShape2D.position.x = 50
			rotate_timer += delta
			if(rotate_timer > rotate_time):
				rotate_timer = 0
				if(sprite.rotation == 0):
					sprite.rotation = deg_to_rad(rotate_value)
				else:
					sprite.rotation = - sprite.rotation

		elif Input.is_action_pressed("move_left"):
			# Move as long as the key/button is pressed.
			velocity.x = -speed
			sprite.flip_h = true
			$CollisionShape2D.position.x = -50
			rotate_timer += delta
			if(rotate_timer > rotate_time):
				rotate_timer = 0
				if(sprite.rotation == 0):
					sprite.rotation = deg_to_rad(rotate_value)
				else:
					sprite.rotation = - sprite.rotation

		else:
			velocity.x = 0
			sprite.rotation = deg_to_rad(0)
		move_and_collide(velocity * delta)

