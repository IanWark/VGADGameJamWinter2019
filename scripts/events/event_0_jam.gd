extends "res://scripts/event.gd"

func _ready():
	._ready()
	scene = "res://scenes/events/event_0_jam.tscn"
	set_locked()
	locked_event = true

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
