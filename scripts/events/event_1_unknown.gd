extends "res://scripts/events/event_unknown.gd"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	scene = "res://scenes/events/event_1_unknown.tscn"
	correct_event = "event_1_a"
	set_locked()
