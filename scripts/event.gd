extends "res://scripts/draggable.gd"

const EVENT = "event"
const EVENT_UNKNOWN = "event_unknown"

var locked_event = false
var finished_event = false
var clues = []

onready var anim_player = $AnimationPlayer
onready var label = $background/Label
onready var strings = get_tree().get_root().get_node("Main/strings")

# This is so we can check if an object is a clue
func get_class():
	return EVENT

func get_event_type():
	return EVENT

func _ready():
	._ready()
	
	if !being_viewed:
		anim_player.play("create")

func _process(delta):
	view_item_check()
	if !locked_event:
		dragging_checks(delta)

func set_locked():
	locked_event = true
	main._remove_draggable(self)

func check_for_submission():
	var overlapping = area.get_overlapping_areas()
	for area in overlapping:
		var area_parent = area.get_parent()
		if area_parent.get_class() == EVENT && area_parent.get_event_type() == EVENT_UNKNOWN && !area_parent.anim_player.is_playing():
			if area_parent.submit(self):
				# Success
				if !finished_event:    # We only want to call this once
					# Move event to submitted area
					position = area_parent.global_position
					anim_player.play("fade_in")
					set_locked()
					main.move_event_to_locked(self)
					
				finished_event = true
			else:
				# Failure
				# Move event down and place it a bit randomly to avoid overlap
				position = area_parent.global_position + Vector2(randi()%41-21, 200 + randi()%41-21)

func mouse_dragging(delta):
	var event_unknown = main.event_unknown
	if event_unknown != null:
		event_unknown.start_halo()
	.mouse_dragging(delta)

# Called constantly whenever mouse is released
func mouse_released():
	check_for_submission()
	.mouse_released()

func remove_event():
	set_locked()
	strings.delete_connected_strings(self)
	anim_player.play("destroy")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "destroy":
		queue_free()

func clue_attached(clue):
	clues.append(clue.get_name())
	set_text()

func clue_detached(clue):
	clues.remove(clues.find(clue.get_name()))
	set_text()

func set_text():
	pass
