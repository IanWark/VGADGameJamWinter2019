extends "res://scripts/events/event_unknown.gd"

func _ready():
	._ready()
	scene = "res://scenes/events/event_1_unknown.tscn"
	correct_event = "event_1_a"
	banned_strings = ["crowbar", "panel"]
	required_strings = ["key"]
	set_locked()
