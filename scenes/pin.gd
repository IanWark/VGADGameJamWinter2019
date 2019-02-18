extends Sprite

onready var s = get_tree().get_root().get_node("Main/strings")

var highlighted = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (self.highlighted && Input.is_action_pressed("left_click")): #When clicking
		print("clicked me! My parent is ", get_parent(), "and I am at position ", self.global_position)
		s.creating_string = true
		
		# If the first pin has been clicked, this is the second click. Finish adding the string
		if (s.parent1 != null):
			s.pin_pos_2 = self.global_position
			s.parent2 = get_parent()
			s.creating_string = false
			
			if(s.parent1.get_class() == "event"):
				if(s.parent2.get_class() == "clue"):
					# One is an event, the other a clue, can make the tie
					s.strings.append(s.RedString.new(s.pin_pos_1, s.pin_pos_2, s.parent1, s.parent2))
			elif(s.parent1.get_class() == "clue"):
				if(s.parent2.get_class() == "event"):
					# Other way around, still valid, make the tie
					s.strings.append(s.RedString.new(s.pin_pos_1, s.pin_pos_2, s.parent2, s.parent1))
			# Clean up regardless of if tie was made
			s.parent1 = null
			s.parent2 = null
		else:
			s.pin_pos_1 = self.global_position
			s.parent1 = get_parent()
				
		#strings_node.strings.append(strings_node.RedString.new(Vector2(0,0), self.global_position, 0, 0))

func _on_Area2D_mouse_entered():
	self.highlighted = true

func _on_Area2D_mouse_exited():
	self.highlighted = false