extends "res://scripts/event.gd"

const NORMAL = "He tricked the alarm system. But how?"
const DAMAGE = "He swapped the jewel to trick the pressure plate. But with what?"

const CROWBAR = "He used a crowbar to trick the alarm system. But how?"
const DAMAGE_CROWBAR = "He tricked the pressure plate by swapping in a crowbar."

const WIRECUTTERS = "He used some wire cutters to trick the alarm system. But how?"
const DAMAGE_WIRECUTTERS = "He tricked the pressure plate by swapping in wire cutters."

const CLOCK = "He used a a clock off the wall to trick the alarm system. But how?"
const DAMAGE_CLOCK = "He tricked the pressure plate by swapping in a clock."

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_a.tscn"

func set_text():
	var has_damage = clues.has("damage")
	var has_wirecutters = clues.has("wirecutters")
	var has_crowbar = clues.has("crowbar")
	var has_clock = clues.has("clock")
	
	var count = int(has_damage) + int(has_wirecutters) + int(has_crowbar) + int(has_clock)
	
	if count == 2 && has_damage && has_wirecutters:
		label.text = DAMAGE_WIRECUTTERS
	elif count == 2 && has_damage && has_crowbar:
		label.text = DAMAGE_CROWBAR
	elif count == 2 && has_damage && has_clock:
		label.text = DAMAGE_CLOCK
	elif count == 1 && has_damage:
		label.text = DAMAGE
	elif count == 1 && has_wirecutters:
		label.text = WIRECUTTERS
	elif count == 1 && has_crowbar:
		label.text = CROWBAR
	elif count == 1 && has_clock:
		label.text = CLOCK
	else: 
		label.text = NORMAL