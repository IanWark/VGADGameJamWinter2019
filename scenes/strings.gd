extends Node2D

var COLOR = Color(255, 0, 0)
var THICKNESS = 3

var creating_string = false
var current_pin_pos = Vector2(0,0)

var strings = []
var data = []
var parent1 = null
var parent2 = null
var pin_pos_1
var pin_pos_2

class RedString:
	var _pin_pos1
	var _pin_pos2
	var _event
	var _clue

	func _init(pin_pos1, pin_pos2, event, clue):
		self._pin_pos1 = pin_pos1
		self._pin_pos2 = pin_pos2
		self._event = event
		self._clue = clue

	func get_data():
		return [self._pin_pos1, self._pin_pos2, self._event, self._clue]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	update()

func _draw():
	if creating_string:
		draw_line(pin_pos_1, get_global_mouse_position(), COLOR, THICKNESS)
	for string in strings:
		data = string.get_data()
		draw_line(data[0], data[1], COLOR, THICKNESS)
	#draw_line(Vector2(0,0), get_global_mouse_position(), COLOR, THICKNESS)