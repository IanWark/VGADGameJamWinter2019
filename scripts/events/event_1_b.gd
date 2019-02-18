extends "res://scripts/event.gd"

const NORMAL = "He broke in through a side door. But how?"
const CROWBAR = "He pried the door open with a crowbar."
const KEY = "He unlocked the door with a stolen key."

func _ready():
	._ready()
	scene = "res://scenes/events/event_1_b.tscn"

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
