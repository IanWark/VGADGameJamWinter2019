extends "res://scripts/event.gd"

func _ready():
	._ready()
	scene = "res://scenes/events/event_0_jam.tscn"
	set_locked()
	locked_event = true
	
	anim_player.stop()
	position = Vector2(0, 0)

