extends Node2D

var COLOR = Color(255, 0, 0)
var THICKNESS = 3

var creating_string = false
var current_pin_pos = Vector2(0,0)

var strings = []
var data = []
var parent1 = null
var parent2 = null
var pin1
var pin2

class RedString:
	var _pin1
	var _pin2
	var _event
	var _clue

	func _init(pin1, pin2, event, clue):
		self._pin1 = pin1
		self._pin2 = pin2
		self._event = event
		self._clue = clue
		
		event.clue_attached(clue)

	func get_data():
		return [self._pin1, self._pin2, self._event, self._clue]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	update()

func _draw():
	if creating_string:
		draw_line(pin1.global_position, get_global_mouse_position(), COLOR, THICKNESS)
	for string in strings:
		data = string.get_data()
		draw_line(data[0].global_position, data[1].global_position, COLOR, THICKNESS)
	#draw_line(Vector2(0,0), get_global_mouse_position(), COLOR, THICKNESS)

func delete_string(string1, string2):
	var data
	for string in strings:
		data = string.get_data()
		if (data[2] == string1 || data[3] == string1):
			if (data[2] == string2 || data[3] == string2):
				string._event.clue_detached(string._clue)
				strings.erase(string)
				return true
	return false

func delete_connected_strings(item):
	var data
	for string in strings:
		data = string.get_data()
		if (data[2] == item || data[3] == item):
			string._event.clue_detached(string._clue)
			strings.erase(string)

func string_exists(string1, string2):
	var data
	for string in strings:
		data = string.get_data()
		if (data[2] == string1 || data[3] == string1):
			if (data[2] == string2 || data[3] == string2):
				return true
	return false