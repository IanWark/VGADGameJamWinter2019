extends Node2D

const DEFAULT_Z_INDEX = 1
const UPPER_Z_INDEX = 2

var can_drag = true
var being_viewed = false

var mouse_in = false
var dragging = false
var mouse_to_center_set = false
var mouse_to_center
var draggable_pos
var mouse_pos

# Scene file used to create the object
# Must be set to match for each inherited object
var scene = null

onready var pin = $Pin
onready var area = $Area2D
onready var main = get_tree().get_root().get_node("Main")

# Click vs Drag timer
var timer= 0
var timer_wait_time = 0.06

# This is so we can check if an object is a clue
func get_class():
	return "draggable"

func _ready():
	if being_viewed:
		pin.hide()
	
	# Prevents multidrag
	if !being_viewed:
		mouse_in = false
		main._remove_draggable(self)

func set_to_being_viewed():
	being_viewed = true
	scale = Vector2(0.75,0.75)
	# Any onready vars need to be changed in ready

func _process(delta):
	view_item_check()
	dragging_checks(delta)

func view_item_check():
	if mouse_in && Input.is_action_just_pressed("right_click"):
		if scene != null:
			main.view_item(scene)

func dragging_checks(delta):
	if (dragging && Input.is_action_pressed("left_click")): #While dragging
		mouse_dragging(delta)
			
	elif (mouse_in && Input.is_action_pressed("left_click")): #When clicking
		#First we set mouse_to_center as a static vector
		#for preventing the draggable to move its center to the mouse position
		if not mouse_to_center_set:
			draggable_pos = self.position
			mouse_pos = get_viewport().get_mouse_position()
			mouse_to_center = restaVectores(draggable_pos, mouse_pos)
			mouse_to_center_set = true
		#We set the dragging to true
		z_index = UPPER_Z_INDEX
		dragging = can_drag
			
	else: 
		mouse_released()

func mouse_dragging(delta):
	timer += delta;
	
	if can_drag:
		mouse_pos = get_viewport().get_mouse_position()

		#Set the position of the draggable to
		#mouse position + static mouse_to_center vector
		var position = sumaVectores(mouse_pos, mouse_to_center)

		set_position(position)

# Called constantly whenever mouse is released
func mouse_released():
	if timer > 0 && timer <= timer_wait_time:
		print("click")
	timer = 0
	mouse_to_center_set = false #Set this to false so we can set mouse_to_center again
	z_index = DEFAULT_Z_INDEX
	dragging = false

func _on_Area2D_mouse_entered():
	if !being_viewed:
		mouse_in = true
		main._add_draggable(self) #Add the draggable to the draggable list

func _on_Area2D_mouse_exited():
	if !being_viewed:
		mouse_in = false
		main._remove_draggable(self)  #Remove the draggable from the draggable list

func restaVectores(v1, v2): #vector substraction
	return Vector2(v1.x - v2.x, v1.y - v2.y)

func sumaVectores(v1, v2): #vector sum
	return Vector2(v1.x + v2.x, v1.y + v2.y)