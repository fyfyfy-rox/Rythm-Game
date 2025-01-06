extends Node2D

@onready var pause_menu = $"CanvasLayer/Pause Menu"

var paused = false

func _ready():
	AudioPlayer_Menu.stop_music()
	var scene_path = get_tree().current_scene.scene_file_path  # Pfad zur aktuellen Szene
	if not Global.scene_states.has(scene_path):
		Global.scene_states[scene_path] = false  # Standardwert: Szene wurde noch nicht betreten
		print("Szenenstatus für", scene_path, "initialisiert.")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Set mouse mode to "captured", so the mouse is hidden initially
	if not Global.scene_states[scene_path]:
		Global.scene_states[scene_path] = true  # Szene als besucht markieren
	else:
		$Witch.global_position = Global.witch_position
		$Witch.update_animation_parameter(Global.witch_direction)  # Richtung setzen
		print("Spielerposition gesetzt:", Global.witch_position, "Blickrichtung:", Global.witch_direction)


func _process(_delta):
	if Input.is_action_just_pressed("pause"):  
		toggle_pause()  # Toggle the pause state and menu visibility


func toggle_pause():
	paused = !paused  # Invert the pause state (if the game is paused, resume it; otherwise, pause it)
	
	if paused and !Global.inputs_disabled:
		# If the game is paused
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Make the mouse visible
		pause_menu.show()  # Show the pause menu
		get_tree().paused = true  # Pause the game (stops input and game logic)
	else:
		# If the game is resumed
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Hide the mouse
		pause_menu.hide()  # Hide the pause menu
		get_tree().paused = false  # Resume the game (allows input and game logic)
