extends "res://scripts/events/event_unknown.gd"

func _ready():
	._ready()
	scene = "res://scenes/events/event_2_unknown.tscn"
	correct_event = "event_2_a"
	banned_strings = ["crowbar", "panel"]
	required_strings = ["clock"]
	set_locked()
