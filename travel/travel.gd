extends Node2D


@onready var interactables = $Interactables
@onready var player = $Player

func _ready():
	AudioManager.play_music("daytime.mp3")
	for child in interactables.get_children():
		if(child.get_class() == "Area2D"):
			child.connect("body_entered", on_area_entered.bind(child))
			child.connect("body_exited", on_area_exited.bind(child))
	pass # Replace with function body.

func on_area_entered(_event, target):
	print("wow: ", target.name)
	player.interactable = target

func on_area_exited(_event, target):
	print("no: ", target.name)
	if(player.interactable == target):
		player.interactable = null