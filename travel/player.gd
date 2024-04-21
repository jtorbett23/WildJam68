extends CharacterBody2D

@export var speed : int = 600
var interactable = false
var settingsMenu = preload("res://menu/settingsMenu.tscn")
var enabled : bool = false
@onready var travel_scene = $"../"
var height_change = 40

@onready var sprite = $Sprite2D
@onready var qmark = $QMark

@onready var sure = $"../UI/Sure"
@onready var info = $"../UI/Info"

func _ready():
	sure.connect("response", handle_response)
	info.connect("response_ok", handle_ok)

func _input(event):
	if event.is_action_pressed("interact"):
		# $CanvasLayer.add_child(settingsMenu.instantiate())
		if(interactable):
			if(interactable.name == "Office-Exit"):
				Camera.transition.fade(Vector2(interactable.target.position.x, position.y - height_change))
			elif(interactable.name == "Office-Enter"):
				Camera.transition.fade(Vector2(interactable.target.position.x, position.y + height_change))
			elif("Painting" in interactable.name):
				if(interactable.is_placed == true and interactable.is_locked == false):
					enabled = false
					var info_msg = "This painting is worth £{0}. If you take it you must replace it with a forgery".format({"0": str(interactable.value)})
					sure.setup("take this painting", info_msg, interactable)
				elif(interactable.is_placed == false and interactable.is_forged == true):
					enabled = false
					sure.setup("place forged painting", "The painting will be locked from further changes", interactable)
				elif(interactable.is_placed == false and interactable.is_forged == false):
					enabled = false
					info.setup("You require a forged painting to replace here")
				elif(interactable.is_placed == true and interactable.is_locked == true):
					enabled = false
					info.setup("This painting is locked from further changes")
			elif("Hall-Exit" in interactable.name):
				sure.show()
				sure.setup("exit", "Exiting will end the heist", null)
				enabled = false
			elif(interactable.name == "Computer"):
				var paintings_data = GameData.get_dict("Paintings")
				var has_painting = false
				for p in paintings_data.values():
					if(p["is_placed"] == false):
						has_painting = true
				if(has_painting):
					Camera.target = null
					Camera.transition.fade("Draw")
					travel_scene.queue_free()
				else:
					enabled = false
					info.setup("You need a painting to be able to create a forgery")

func handle_response(choice, topic, target):
	enabled = true
	if(topic == "exit"):
		if(choice == "yes"):
			Camera.transition.fade("End")
			Camera.target = null
			travel_scene.queue_free()
	if(topic == "take this painting"):
		if(choice == "yes"):
			target.update_art(false, false)
			sure.target = null
	if(topic == "place forged painting"):
		if(choice == "yes"):
			target.update_art(true,true)
			sure.target = null

func handle_ok():
	enabled = true

	
				

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
			qmark.position.x = 28
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
			qmark.position.x = -28
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

