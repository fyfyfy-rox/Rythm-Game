extends Node2D

@onready var pause_menu = $"CanvasLayer/Pause Menu"  # Reference to the Pause Menu in the CanvasLayer

var paused = false  # Variable to track if the game is paused or not
# _ready function, executed when the node is initialized
func _ready():
	if Global.in_rythm_game == true: #lande for gramps nach rythm game
		$Witch.position.x = 540
		$Witch.position.y = 760
		Global.in_rythm_game = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Set mouse mode to "captured", so the mouse is hidden initially
	await(3)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	if Global.first_city_entered:
		Dialogic.start("overworld_arriving")
		Global.first_city_entered = false
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):  
		toggle_pause()  # Toggle the pause state and menu visibility

func _on_dialogic_signal(signal_name):
	
	if signal_name == "timeline_started":
		_disable_inputs()
	elif signal_name == "timeline_ended":
		_enable_inputs()
	elif signal_name == "choice_start":
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) 
	elif signal_name == "choice_end":
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif signal_name == "start_rythm_game":
		Global.in_rythm_game = true
		get_tree().change_scene_to_file("res://rythm_game_city.tscn")
		
func _disable_inputs():
	
	Global.inputs_disabled = true
	print("Inputs deaktiviert.")

func _enable_inputs():
	Global.inputs_disabled = false
	print("Inputs aktiviert.")
	

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
