extends Node2D


@onready var interactables = $Interactables
@onready var player = $Player

@onready var office = $Rooms/Office

func _ready():
	Camera.transition.connect("fade_start", handle_transition_start)
	Camera.transition.connect("faded_in", handle_transition_middle)
	Camera.transition.connect("faded_out", handle_transition_end)
	Camera.set_follow(player)
	Camera.set_position_y(0)
	AudioManager.play_music("nighttime.mp3")
	for child in interactables.get_children():
		if(child.get_class() == "Area2D"):
			child.connect("body_entered", on_area_entered.bind(child))
			child.connect("body_exited", on_area_exited.bind(child))


func handle_transition_start():
	player.enabled = false

func free():
	queue_free()

func handle_transition_middle(target):
	if(typeof(target) == TYPE_VECTOR2):
		player.position = target

func handle_transition_end():
	player.enabled = true

func on_area_entered(_event, target):
	player.qmark.visible = true
	player.interactable = target

func on_area_exited(_event, target):
	if(player.interactable == target):
		player.qmark.visible = false
		player.interactable = null