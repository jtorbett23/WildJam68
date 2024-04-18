extends ColorRect

var fade_in = false
var fade_out = false
var enabled = false
var wait = false 
@export var speed = 2
var delay = 0.1
var delay_time = 0.0
var target

# @onready var camera = $"../Camera2D"

signal faded_in(target)
signal faded_out()
signal fade_start()

func _ready():
	self.size = get_viewport().get_size()
	self.visible = false

func fade(new_target = null):
	fade_start.emit()
	self.visible = true
	self.color.a = 0
	enabled = true
	fade_in = true
	delay_time = 0.0
	self.target = new_target

func _process(delta):
	if(enabled):
		if(fade_in):
			self.color.a += speed * delta
			if(self.color.a >= 1.0):
				fade_in = false
				wait = true
				faded_in.emit(target)
		elif(wait):
			delay_time += delta
			if(delay_time > delay):
				wait = false
				fade_out = true
		elif(fade_out):
			self.color.a -= speed * delta
			if(self.color.a <= 0.0):
				fade_out = false
				enabled = false
				self.visible = false
				faded_out.emit()
