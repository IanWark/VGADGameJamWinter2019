extends "res://scripts/event.gd"

const NORMAL = "He broke in through the roof. But how?"
const CROWBAR = "He smashed the glass with a crowbar."
const WIRECUTTERS = "He smashed the glass with some wire cutters."
const KEY = "He unlocked the skylight with a stolen key."

func _ready():
	._ready()
	scene = "res://scenes/events/event_1_a.tscn"

func set_text():
	var has_crowbar = clues.has("crowbar")
	var has_key = clues.has("key")
	var has_wirecutters = clues.has("wirecutters")
	
	var count = int(has_crowbar) + int(has_key) + int(has_wirecutters)
	
	if count > 1:
		label.text = NORMAL
	if has_crowbar:
		label.text = CROWBAR 
	elif has_key:
		label.text = KEY 
	elif has_wirecutters:
		label.text = WIRECUTTERS
	else: 
		label.text = NORMAL
