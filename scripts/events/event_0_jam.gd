extends "res://scripts/event.gd"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	scene = "res://scenes/events/event_0_jam.tscn"
	set_locked()
	locked_event = true

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
