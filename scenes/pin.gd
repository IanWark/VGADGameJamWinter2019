extends Sprite

onready var main = get_tree().get_root().get_node("Main")

var highlighted = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if (self.highlighted && Input.is_action_pressed("left_click")): #When clicking
		print("clicked me! My parent is ", get_parent())

func _on_Area2D_mouse_entered():
	main.highlight(self)

func _on_Area2D_mouse_exited():
	main.unhighlight(self)