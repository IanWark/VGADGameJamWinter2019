extends ColorRect

onready var handwritten = $handwritten
onready var the_phoenix_sapphire = $THE_PHOENIX_SAPPHIRE
onready var continue_prompt_anim = $continue_prompt/AnimationPlayer
onready var sprite = $CenterContainer/Control/Sprite

var can_continue = false

func _input(event):
	# Change scene to credits
	if can_continue && event is InputEventMouseButton && !event.is_pressed():
		get_tree().change_scene("res://scenes/credits.tscn")


func _on_AnimationPlayer_animation_finished(anim_name):	
	handwritten.visible = false
	the_phoenix_sapphire.visible = true
	sprite.visible = true
	
	continue_prompt_anim.play("appear")
	can_continue = true
