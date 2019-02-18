extends Sprite

onready var strings_node = get_tree().get_root().get_node("Main/strings")

var highlighted = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (self.highlighted && Input.is_action_pressed("left_click")): #When clicking
		print("clicked me! My parent is ", get_parent(), "and I am at position ", self.global_position)
		strings_node.creating_string = !strings_node.creating_string
		#strings_node.strings.append(strings_node.RedString.new(Vector2(0,0), self.global_position, 0, 0))

func _on_Area2D_mouse_entered():
	self.highlighted = true

func _on_Area2D_mouse_exited():
	self.highlighted = false