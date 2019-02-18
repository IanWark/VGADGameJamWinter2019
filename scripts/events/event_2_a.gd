extends "res://scripts/event.gd"

const NORMAL = "He snuck past the guard. But how?"
const CLOCK = "A jumping minute hand? This guard fell asleep on the job."
const CROWBAR = "He smashed something with a crowbar to distract the guard."
const WIRECUTTERS = "He distracted the guard by throwing some wire cutters."

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_a.tscn"

func set_text():
	var has_crowbar = clues.has("crowbar")
	var has_wirecutters = clues.has("wirecutters")
	var has_clock = clues.has("clock")
	
	var count = int(has_crowbar) + int(has_wirecutters) + int(has_clock)
	
	if count > 1:
		label.text = NORMAL
	elif has_crowbar:
		label.text = CROWBAR 
	elif has_clock:
		label.text = CLOCK 
	elif has_wirecutters:
		label.text = WIRECUTTERS 
	else: 
		label.text = NORMAL