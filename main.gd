extends Node

var main_menu_ref = preload("res://menu/mainMenu.tscn")
var travel_ref = preload("res://travel/travel.tscn")
var draw_ref = preload("res://draw/draw_tool.tscn")

var main_menu 
# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu = main_menu_ref.instantiate()
	main_menu.connect("start_game", start_game)
	add_child(main_menu)
	Camera.transition.connect("faded_in", switch_scene)

func start_game():
	Camera.transition.fade("Travel")

func switch_scene(target):
	if(target == "Travel"):
		main_menu.queue_free()
		add_child(travel_ref.instantiate())
