extends "res://scripts/event.gd"

const NORMAL = "He deactivated the alarm system. But where was it?"
const PANEL = "He deactivated the alarm system inside the pedestal. How?"

const WIRECUTTERS = "He cut the alarm's wires. But where were the wires?"
const PANEL_WIRECUTTERS = "He cut the alarm's wires inside the pedestal."

const CROWBAR = "He smashed up the alarm system. But where was the alarm?"
const PANEL_CROWBAR = "He smashed up the alarm system inside the pedestal."

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_a.tscn"

func set_text():
	var has_panel = clues.has("panel")
	var has_wirecutters = clues.has("wirecutters")
	var has_crowbar = clues.has("crowbar")
	
	var count = int(has_panel) + int(has_wirecutters) + int(has_crowbar)
	
	if count == 2 && has_panel && has_wirecutters:
		label.text = PANEL_WIRECUTTERS
	elif count == 2 && has_panel && has_crowbar:
		label.text = PANEL_CROWBAR
	elif count == 1 && has_panel:
		label.text = PANEL
	elif count == 1 && has_wirecutters:
		label.text = WIRECUTTERS
	elif count == 1 && has_crowbar:
		label.text = CROWBAR
	else: 
		label.text = NORMAL
