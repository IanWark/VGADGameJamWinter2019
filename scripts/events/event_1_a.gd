extends "res://scripts/event.gd"

const NORMAL = "He went in through the roof. But how?"
const CROWBAR = "He smashed the glass with a crowbar."
const KEY = "He unlocked the skylight with a stolen key."

func _ready():
	._ready()
	scene = "res://scenes/events/event_1_a.tscn"

func set_text():
	var has_crowbar = clues.has("crowbar")
	var has_key = clues.has("key")
		
	if has_crowbar && has_key:
		label.text = NORMAL
	elif has_crowbar:
		label.text = CROWBAR 
	elif has_key:
		label.text = KEY 
	else: 
		label.text = NORMAL
