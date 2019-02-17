# Made with love by JuanCarlos "Juanky" Aguilera
# Github Repo: https://github.com/JCAguilera/godot3-drag-and-drop

extends Node

var draggables = []
var top_draggable = null
var dragging = false
var top_set = false
var viewed_item = null

onready var item_view_bg = $ItemViewBG
onready var center_container = $ItemViewBG/CenterContainer

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

# Called when an item is right clicked and wants to be viewed
func view_item(scene):
	if viewed_item == null:
		# view item under cursor
		# first create a larger version of the object 
		viewed_item = load(scene).instance()
		viewed_item.scale = Vector2(0.75,0.75)
		viewed_item.viewed_item = true
		# place object in center
		center_container.add_child(viewed_item)
		# darken screen and show object
		item_view_bg.visible = true

class DraggablesSorter: #Custom sorter
	static func z_index(a, b): #Sort by z_index
		if a.z_index > b.z_index:
			return true
		return false

func _add_draggable(sprt): #Add draggable to list
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
