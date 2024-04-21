extends Node

var main_menu_ref = preload("res://menu/mainMenu.tscn")
var travel_ref = preload("res://travel/travel.tscn")
var draw_ref = preload("res://draw/draw_tool.tscn")
var end_screen_ref = preload("res://end_screen.tscn")
# var travel
# var main_menu
# var draw
# var end_screen
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(main_menu_ref.instantiate())
	Camera.transition.connect("faded_in", switch_scene)


func switch_scene(target):
	if(typeof(target) == TYPE_STRING):
		if(target == "Travel"):
			add_child(travel_ref.instantiate())
		elif(target == "Draw"):
			add_child(draw_ref.instantiate())
		elif(target == "Main"):
			add_child(main_menu_ref.instantiate())
		elif(target == "End"):
			add_child(end_screen_ref.instantiate())

		
