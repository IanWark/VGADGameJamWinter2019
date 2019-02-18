extends Sprite

onready var s = get_tree().get_root().get_node("Main/strings")

var highlighted = false
var just_clicked = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (self.highlighted && Input.is_action_pressed("left_click")): #When clicking
		if(!just_clicked):
			just_clicked = true
			s.creating_string = true
			
			# If the first pin has been clicked, this is the second click. Finish adding the string
			if (s.parent1 != null):
				s.pin2 = self
				s.parent2 = get_event_or_clue_parent()
				s.creating_string = false
				
				print(s.parent1.get_class())
				print(s.parent2.get_class())
				
				if(s.parent1.get_class() == "event" && !s.parent1.locked_event):
					if(s.parent2.get_class() == "clue"):
						# One is an event, the other a clue, can make the tie or remove if it exists
						if(!s.string_exists(s.parent1, s.parent2)):
							s.strings.append(s.RedString.new(s.pin1, s.pin2, s.parent1, s.parent2))
				elif(s.parent1.get_class() == "clue"):
					if(s.parent2.get_class() == "event" && !s.parent2.locked_event):
						# Other way around, still valid, make the tie or remove if it exists
						if(!s.string_exists(s.parent1, s.parent2)):
							s.strings.append(s.RedString.new(s.pin2, s.pin1, s.parent2, s.parent1))
				# Clean up regardless of if tie was made
				s.parent1 = null
				s.parent2 = null
			else:
				s.pin1 = self
				s.parent1 = get_event_or_clue_parent()
					
			#strings_node.strings.append(strings_node.RedString.new(Vector2(0,0), self.global_position, 0, 0))
			
	else:
		just_clicked = false

# Events have their parent 2 nodes up
# Clues only have parents 1 node up
func get_event_or_clue_parent():
	var parent = get_parent()
	if parent.get_class() != "clue" and parent.get_class() != "event":
		parent = parent.get_parent()
	
	return parent

func _on_Area2D_mouse_entered():
	self.highlighted = true

func _on_Area2D_mouse_exited():
	self.highlighted = false
	