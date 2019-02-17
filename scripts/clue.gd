extends "res://scripts/draggable.gd"

# This is so we can check if an object is a clue
func get_class():
	return "clue"

func _ready():
	._ready()
	scene = "res://scenes/clue.tscn"
	