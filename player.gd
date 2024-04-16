extends CharacterBody2D

@export var speed : int = 400

@onready var area : Area2D = $"../Area2D"

var interactable = false

# Called when the node enters the scene tree for the first time.
func _ready():
	area.connect("body_entered", on_area_entered)
	area.connect("body_exited", on_area_exited)
	pass # Replace with function body.

func on_area_entered(_event):
	print("yo")
	interactable = true

func on_area_exited(_event):
	print("no")
	interactable = false

func _input(event):
	if event.is_action_pressed("interact"):
		if(interactable):
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
