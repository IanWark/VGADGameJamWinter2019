extends "res://scripts/event.gd"

const NORMAL = "He knocked the guard out. But how?"
const CROWBAR = "He knocked the guard out with a crowbar."
const CLOCK = "He knocked the guard out with the clock off the wall."
const WIRECUTTERS = "He... I'm not sure how this works."

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_b.tscn"

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
