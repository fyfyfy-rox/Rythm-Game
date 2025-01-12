extends Node2D

@onready var pause_menu = $"CanvasLayer/Pause Menu"  # Reference to the Pause Menu in the CanvasLayer
@onready var drummerboy = $Drummerboy/AnimatedSprite2D
@onready var bg_wald = $AudioStreamPlayer2D

var paused = false  # Variable to track if the game is paused or not

func _ready():
	AudioPlayer_Menu.stop_music()
	var scene_path = get_tree().current_scene.scene_file_path  # Pfad zur aktuellen Szene
	if not Global.scene_states.has(scene_path):
		Global.scene_states[scene_path] = false  # Standardwert: Szene wurde noch nicht betreten
		print("Szenenstatus für ", scene_path, "initialisiert.")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Set mouse mode to "captured", so the mouse is hidden initially
	Dialogic.signal_event.connect(_on_dialogic_signal)  # Connect Dialogic signals
	if not Global.scene_states[scene_path]:
		Dialogic.start("Forrest_Speech_1")
		Global.scene_states[scene_path] = true  # Szene als besucht markieren
		print("Dialog gestartet und Szene als betreten markiert.")  # Start the Dialogic timeline
	else:
		$Witch.global_position = Global.witch_position
		$Witch.update_animation_parameter(Global.witch_direction)  # Richtung setzen
		print("Spielerposition gesetzt:", Global.witch_position, "Blickrichtung:", Global.witch_direction)

func _process(_delta):
	# If the player presses the Pause button (ESC)
	if Input.is_action_just_pressed("pause"):  
		toggle_pause()  # Toggle the pause state and menu visibility
	
	if Global.tree_interacted == 1:
		$Rain.visible = false
		$Wasser/CollisionShape2D.disabled = true
		$Wasser.visible = false
		Global.tree_interacted = 0
		TransitionScreen.rythm_transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file("res://Scenen/rythm_game.tscn")

func _on_dialogic_signal(signal_name):
	if signal_name == "timeline_started":
		_disable_inputs()
	elif signal_name == "timeline_ended":
		_enable_inputs()

func _disable_inputs():
	
	Global.inputs_disabled = true
	print("Inputs deaktiviert.")

func _enable_inputs():
	Global.inputs_disabled = false
	print("Inputs aktiviert.")
	
func _exit_tree():
	bg_wald.stop()  # Musik stoppen


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
