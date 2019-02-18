extends "res://scripts/event.gd"

const NORMAL = "He snuck past the guard. But how?"
const CLOCK = "A jumping minute hand? This guard falls asleep on the job."

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_a.tscn"

func set_text():
	var has_crowbar = clues.has("crowbar")
	var has_clock = clues.has("clock")
	
	if has_crowbar && has_clock:
		label.text = NORMAL
	elif has_clock:
		label.text = CLOCK 
	else: 
		label.text = NORMAL