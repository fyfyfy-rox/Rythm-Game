extends Node2D

@onready var pause_menu = $"CanvasLayer/Pause Menu"  # Reference to the Pause Menu in the CanvasLayer

var paused = false  # Variable to track if the game is paused or not

# _ready function, executed when the node is initialized
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Set mouse mode to "captured", so the mouse is hidden initially

# This function is called every frame to check for input
func _process(delta):
	# If the player presses the Pause button (ESC)
	if Input.is_action_just_pressed("pause"):  
		toggle_pause()  # Toggle the pause state and menu visibility

# Function to toggle the pause state and menu visibility
func toggle_pause():
	paused = !paused  # Invert the pause state (if the game is paused, resume it; otherwise, pause it)
	
	if paused:
		# If the game is paused
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)  # Make the mouse visible
		pause_menu.show()  # Show the pause menu
		get_tree().paused = true  # Pause the game (stops input and game logic)
	else:
		# If the game is resumed
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Hide the mouse
		pause_menu.hide()  # Hide the pause menu
		get_tree().paused = false  # Resume the game (allows input and game logic)
