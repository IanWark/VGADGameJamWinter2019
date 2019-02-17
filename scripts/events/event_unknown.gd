extends "res://scripts/event.gd"

var correct_event # must be overwritten with what event is the solution

func _ready():
	._ready()
	scene = "res://scenes/events/event_unknown.tscn"
	set_locked()

# Event submits itself
func submit(event):
	return event.get_name() == correct_event
		
