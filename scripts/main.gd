# Made with love by JuanCarlos "Juanky" Aguilera
# Github Repo: https://github.com/JCAguilera/godot3-drag-and-drop

extends Node

const EVENT_2_UNKNOWN = "res://scenes/events/event_2_unknown.tscn"
const EVENT_2_A = "res://scenes/events/event_2_a.tscn"
const EVENT_2_B = "res://scenes/events/event_2_b.tscn"

const EVENT_3_UNKNOWN = "res://scenes/events/event_3_unknown.tscn"
const EVENT_3_A = "res://scenes/events/event_3_a.tscn"
const EVENT_3_B = "res://scenes/events/event_3_b.tscn"

var draggables = []
var top_draggable = null
var dragging = false
var top_set = false
var viewed_item = null
var current_event = 1

var event_unknown

const songs = ["res://music/Dances and Dames.ogg"]
var current_song = 0
onready var music_player = $AudioStreamPlayer

onready var event_pos_template = $"Locked Events/event_sequence/event_pos_0"
onready var event_sequence = $"Locked Events/event_sequence"

onready var new_event_pos_1 = $"new_event_pos_1"
onready var new_event_pos_2 = $"new_event_pos_2"

onready var wrong_answer = $event_1_b
onready var item_view_bg = $ItemViewLayer/ItemViewBG
onready var center_container = $ItemViewLayer/ItemViewBG/CenterContainer

func _ready():
	event_unknown = $"Locked Events/event_sequence/event_pos_1/Control/event_unknown"

func _process(delta):
	if Input.is_action_pressed("left_click"): #When we click
		if viewed_item != null:
			# Stop viewing selected item
			item_view_bg.visible = false
			viewed_item.queue_free()
			viewed_item = null
		else:
			if not top_set: #If there's no top we set one
				top_draggable = _top_draggable() #Get the draggable on top (largest z_index)
				if not top_draggable == null: #If there's a draggable
					top_draggable.can_drag = true #We set can_drag to true
				top_set = true
			dragging = true #We are dragging now
	if dragging && Input.is_action_pressed("left_click"): #If mouse dragging
		pass
	else: #When we release
		if not top_draggable == null:
			top_draggable.can_drag = false #Set can_drag to false
		top_draggable = null #Top draggable to null
		top_set = false
		dragging = false
		if not event_unknown == null:
			event_unknown.stop_halo()

# Called when an item is right clicked and wants to be viewed
func view_item(item):
	if viewed_item == null:
		# view item under cursor
		# first create a larger version of the object 
		viewed_item = item.duplicate()
		viewed_item.set_to_being_viewed()
		# place object in center
		center_container.add_child(viewed_item)
		# darken screen and show object
		item_view_bg.visible = true

func move_event_to_locked(event):
	if event_unknown != null:
		var event_position = event_unknown.get_parent()
		event_position = add_child(event)
		
		event_unknown.queue_free()
		event_unknown = null
		
		wrong_answer.remove_event()
		
		var unknown_scene 
		var a_scene
		var b_scene
		if current_event == 1:
			unknown_scene = EVENT_2_UNKNOWN
			a_scene = EVENT_2_A
			b_scene = EVENT_2_B
		elif current_event == 2:
			unknown_scene = EVENT_3_UNKNOWN
			a_scene = EVENT_3_A
			b_scene = EVENT_3_B
		elif current_event == 3:
			$ItemViewLayer/ItemViewBG/AnimationPlayer.play("fade_to_black")
			return
		
		# Get new container for a locked event
		var new_locked_container = event_pos_template.duplicate()
		new_locked_container.get_node("Control/event_0_JAM").queue_free()
		
		# Create new unknown event and add it to container
		event_unknown = load(unknown_scene).instance()
		new_locked_container.get_node("Control").add_child(event_unknown)
		
		# Add container to locked event sequence
		event_sequence.add_child(new_locked_container)
		
		# Create the new possible events
		var event_a = load(a_scene).instance()
		add_child(event_a)
		event_a.global_position = new_event_pos_1.global_position 
		
		var event_b = load(b_scene).instance()
		add_child(event_b)
		event_b.global_position = new_event_pos_2.global_position 
		
		# Set which answer is wrong so we can delete it later
		wrong_answer = event_b
		
		current_event += 1

class DraggablesSorter: #Custom sorter
	static func z_index(a, b): #Sort by z_index
		if a.z_index > b.z_index:
			return true
		return false

func _add_draggable(sprt): #Add draggable to list
	# Don't add if object is a locked event
	if sprt.get_class() == "event" && sprt.locked_event == true:
		return
	if not draggables.find(sprt) == -1: #If draggable exists
		return #Do nothing
	draggables.append(sprt) #Add draggable to list

func _remove_draggable(sprt): #Remove draggable from list
	if sprt == top_draggable and dragging: #This is for preventing the draggable dropping when we move the mouse fast
		 return
	sprt.can_drag = false #Set can_drag to false
	var idx = draggables.find(sprt) #find the index
	draggables.remove(idx) #remove

func _top_draggable(): #Get the top draggable
	if len(draggables) == 0: #If the list is empty
		return null
	draggables.sort_custom(DraggablesSorter, "z_index") #Sort by z_index
	for i in draggables: #Set all can_drag to false
		i.can_drag = false
	return draggables[0] #Return top draggable

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://scenes/ending.tscn")

func _on_AudioStreamPlayer_finished():
	current_song += 1
	if current_song > songs.size()-1:
		current_song = 0
	
	music_player.play(songs[current_song])
