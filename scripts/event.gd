extends "res://scripts/draggable.gd"

const EVENT_UNKNOWN = "event_unknown"

var locked_event = false

onready var anim_player = $AnimationPlayer

# This is so we can check if an object is a clue
func get_class():
	return "event"

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
		if area_parent.get_name() == EVENT_UNKNOWN:
			if area_parent.submit(self):
				# Move event to submitted area
				position = area_parent.global_position
				anim_player.play("fade_in")
				set_locked()
				area_parent.queue_free()
				main.event_unknown = null
			else:
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

