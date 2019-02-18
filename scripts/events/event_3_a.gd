extends "res://scripts/event.gd"

const NORMAL = "He deactivated the alarm system. But where was it?"
const PANEL = "He deactivated the alarm system inside the pedestal."

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_a.tscn"

func set_text():
	var has_panel = clues.has("panel")
	
	if has_panel:
		label.text = PANEL 
	else: 
		label.text = NORMAL
