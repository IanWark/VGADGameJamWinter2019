extends "res://scripts/events/event_unknown.gd"

func _ready():
	._ready()
	scene = "res://scenes/events/event_3_unknown.tscn"
	correct_event = "event_3_a"
	set_locked()
