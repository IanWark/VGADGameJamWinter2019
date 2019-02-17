extends "res://scripts/event.gd"

var correct_event # must be overwritten with what event is the solution

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	scene = "res://scenes/events/event_unknown.tscn"
	set_locked()

# Event submits itself
func submit(event):
	return event.get_name() == correct_event
		
