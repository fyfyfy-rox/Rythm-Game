extends Node2D

@onready var drummerboy = $Drummerboy/AnimatedSprite2D
@onready var pause_menu = $"Pause/Pause Menu"
var paused = false



func _ready():
	if Global.drummer:
		drummerboy.visible = true
		drummerboy.play("default")
	AudioPlayer_Menu.stop_music()
	drummerboy.play("default")
	if Global.letzte_szene == "/root/BassRythm":
		Dialogic.start("Drummer_teleport")
	
	var scene_path = get_tree().current_scene.scene_file_path  # Pfad zur aktuellen Szene
	if not Global.scene_states.has(scene_path):
		Global.scene_states[scene_path] = false  # Standardwert: Szene wurde noch nicht betreten
		print("Szenenstatus für", scene_path, "initialisiert.")
	
	Dialogic.signal_event.connect(_on_dialogic_signal)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Set mouse mode to "captured", so the mouse is hidden initially
	if not Global.scene_states[scene_path]:
		Global.scene_states[scene_path] = true  # Szene als besucht markieren
		Dialogic.start("Subway")
	else:
		$Witch.global_position = Global.witch_position
		$Witch.update_animation_parameter(Global.witch_direction)  # Richtung setzen
		print("Spielerposition gesetzt:", Global.witch_position, "Blickrichtung:", Global.witch_direction)

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
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		teleport()
		Dialogic.start("res://addons/dialogic/Dialoge/Drummerboy_rescued.dtl")
	elif signal_name == "start_flute_game":
		white_screen("res://rythm_game_subway_flöte.tscn")
	elif signal_name == "start_bass_game":
		white_screen("res://rythm_game_bass_subway.tscn")
	elif signal_name == "start_drum_game":
		white_screen("res://Scenen/Rythm_Drum.tscn")
func _process(_delta):
	if Input.is_action_just_pressed("pause"):  
		toggle_pause()  # Toggle the pause state and menu visibility

func _disable_inputs():
	
	Global.inputs_disabled = true
	print("Inputs deaktiviert.")

func _enable_inputs():
	Global.inputs_disabled = false
	print("Inputs aktiviert.")
	
func teleport():
	Global.drummer = true
	Global.mana -= 500
	drummerboy.visible = true


func white_screen(path: String):
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	_enable_inputs()
	get_tree().change_scene_to_file(path)

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
