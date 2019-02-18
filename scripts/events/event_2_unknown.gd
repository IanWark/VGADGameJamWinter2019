extends "res://scripts/events/event_unknown.gd"

func _ready():
	._ready()
	scene = "res://scenes/events/event_1_unknown.tscn"
	correct_event = "event_2_a"
	set_locked()
