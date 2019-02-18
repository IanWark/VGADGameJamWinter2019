extends "res://scripts/event.gd"

func _ready():
	._ready()
	scene = "res://scenes/events/event_1_a.tscn"

func mouse_dragging(delta):
	var event_unknown = main.event_unknown
	if event_unknown != null:
		event_unknown.start_halo()
	.mouse_dragging(delta)