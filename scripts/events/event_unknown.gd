extends "res://scripts/event.gd"

var correct_event # must be overwritten with what event is the solution
var banned_strings

onready var halo = $halo
onready var strings = get_tree().get_root().get_node("Main/strings")

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
	anim_player.play("fade_in")
	
	if event.get_name() == correct_event:
		for banned_string_name in banned_strings:
			print("Main/" + banned_string_name)
			var correct_item = get_tree().get_root().get_node("Main/" + correct_event)
			var banned_item = get_tree().get_root().get_node("Main/" + banned_string_name)
			
			if strings.string_exists(correct_item, banned_item):
				return false
		
		return true
	
	return false

func start_halo():
	if not anim_player.is_playing():
		anim_player.play("halo")
		halo.modulate = Color(0,0,0,0)
		halo.visible = true

func stop_halo():
	halo.visible = false
	anim_player.stop()