extends "res://scripts/event.gd"

var correct_event # must be overwritten with what event is the solution

onready var halo = $halo

func get_event_type():
	return "event_unknown"

func _ready():
	._ready()
	scene = "res://scenes/events/event_unknown.tscn"
	set_locked()
	stop_halo()
	anim_player.play("fade_in")

# Event submits itself
func submit(event):
	return event.get_name() == correct_event

func start_halo():
	if not anim_player.is_playing():
		anim_player.play("halo")
		halo.modulate = Color(0,0,0,0)
		halo.visible = true

func stop_halo():
	halo.visible = false
	anim_player.stop()