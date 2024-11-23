extends Node2D


@onready var pause_menu = $"Camera2D/Pause Menu"

var paused = false


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause(paused)


func pause(state):
	paused = !paused
	if paused:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		pause_menu.hide()
		get_tree().paused = false
		

	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().paused = true
		pause_menu.show()
		
		
