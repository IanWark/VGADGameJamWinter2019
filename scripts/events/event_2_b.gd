extends "res://scripts/event.gd"

const NORMAL = "He knocked the guard out. But how?"
const CROWBAR = "He knocked the guard out with a crowbar."

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_b.tscn"

func set_text():
	var has_crowbar = clues.has("crowbar")
	
	if has_crowbar:
		label.text = CROWBAR 
	else: 
		label.text = NORMAL
