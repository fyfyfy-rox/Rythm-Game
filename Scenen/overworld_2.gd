extends Node2D

@onready var pause_menu = $"Pause/Pause Menu"  # Reference to the Pause Menu in the CanvasLayer
@onready var bg_music = $AudioStreamPlayer2D
@onready var gramps_animation = $Gramps/AnimatedSprite2D
@onready var brunnen = $Node2D/AnimatedSprite2D
@onready var drummer = $Drummer/AnimatedSprite2D
var paused = false  # Variable to track if the game is paused or not
# _ready function, executed when the node is initialized
func _ready():
	AudioPlayer_Menu.stop_music()
	bg_music.play()
	gramps_animation.play("default")
	brunnen.play("default")
	drummer.play("default")
	
	if Global.letzte_szene == "/root/Rythm-Game":
		Dialogic.start("Bassist_teleport")
		Global.letzte_szene = ""
		
	
	
	var scene_path = get_tree().current_scene.scene_file_path  # Pfad zur aktuellen Szene
	if not Global.scene_states.has(scene_path):
		Global.scene_states[scene_path] = false  # Standardwert: Szene wurde noch nicht betreten
		print("Szenenstatus für", scene_path, "initialisiert.")
	
	if Global.in_rythm_game == true: #lande for gramps nach rythm game
		$Witch.position.x = 540
		$Witch.position.y = 760
		Global.in_rythm_game = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Set mouse mode to "captured", so the mouse is hidden initially
	await(3)
	Dialogic.signal_event.connect(_on_dialogic_signal)
	 # Prüfen, ob die Szene bereits betreten wurde
	if not Global.scene_states[scene_path]:
		Dialogic.start("overworld_arriving")
		Global.scene_states[scene_path] = true  # Szene als besucht markieren
		print("Dialog gestartet und Szene als betreten markiert.")
	else:
		$Witch.global_position = Global.witch_position
		$Witch.update_animation_parameter(Global.witch_direction)  # Richtung setzen
		print("Spielerposition gesetzt:", Global.witch_position, "Blickrichtung:", Global.witch_direction)
		
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
	elif signal_name == "teleport":
		teleport()
		
func _disable_inputs():
	
	Global.inputs_disabled = true
	print("Inputs deaktiviert.")

func _enable_inputs():
	Global.inputs_disabled = false
	print("Inputs aktiviert.")
	
func _exit_tree():
	bg_music.stop()  # Musik stoppen

func teleport():
	Global.mana -= 50

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
