extends ColorRect

func _ready():
	$music.play(0)

func _input(event):
	# Change scene to credits
	if event is InputEventMouseButton: #&& event.position:
		get_tree().quit()
