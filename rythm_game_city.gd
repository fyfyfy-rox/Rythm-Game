extends Node2D

const NODE = preload("res://moving_node_guitar.tscn")
@onready var Witch_animation = $Witch
@onready var Mana = $Mana
@onready var one = $"Tasten/1_on"
@onready var two = $"Tasten/2_on"
@onready var three = $"Tasten/3_on"
@onready var four = $"Tasten/4_on"
@onready var timer1 = $"Tasten/Timer1"
@onready var timer2 = $"Tasten/Timer2"
@onready var timer3 = $"Tasten/Timer3"
@onready var timer4 = $"Tasten/Timer4"
@onready var rythm_map_music = $AudioStreamPlayer_rhytm
@onready var rythm_map_music_melod = $AudioStreamPlayer_melody
@export var midi_player: MidiPlayer

var paused = false  
@onready var pause_menu = $Pause/PauseMenuRythm


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	Witch_animation.play("charge")
	Mana.value = Global.mana
	rythm_map_music.play()
	rythm_map_music_melod.play()
	AudioPlayer_Menu.stop_music()
	# Signal verbinden	
	midi_player.finished.connect(_on_finished)

func _on_finished() -> void:
	print("MIDI-Datei fertig abgespielt. Wechsle Szene...")
	await(3)
	Global.letzte_szene = get_tree().get_current_scene().get_path()
	get_tree().change_scene_to_file("res://Scenen/overworld_2.tscn")
	
func _process(delta: float) -> void:
	Mana.value = Global.mana
	if Input.is_action_just_pressed("1"):
		one.visible = true
		timer1.start()
	if Input.is_action_just_pressed("2"):
		two.visible = true
		timer2.start()
	if Input.is_action_just_pressed("3"):
		three.visible = true
		timer3.start()
	if Input.is_action_just_pressed("4"):
		four.visible = true
		timer4.start()
	if Input.is_action_just_pressed("pause"):  
		toggle_pause()  # Toggle the pause state and menu visibility

func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	print("Event:", event.type)
	print("Channel:", channel.number)
	if event.type == 144:
		if channel.number == 0:
			print("1")
			var node = NODE.instantiate()
			node.position = $Positions/Position1.global_position
			node.speed = 150
			get_parent().add_child(node)
		if channel.number == 1:
			print("2")
			var node = NODE.instantiate()
			node.position = $Positions/Position2.global_position
			node.speed = 150
			get_parent().add_child(node)
		if channel.number == 2:
			print("3")
			var node = NODE.instantiate()
			node.position = $Positions/Position3.global_position
			node.speed = 150
			get_parent().add_child(node)
		if channel.number == 3:
			print("4")
			var node = NODE.instantiate()
			node.position = $Positions/Position4.global_position
			node.speed = 150
			get_parent().add_child(node)



func _on_timer_1_timeout() -> void:
	one.visible = false


func _on_timer_2_timeout() -> void:
	two.visible = false


func _on_timer_3_timeout() -> void:
	three.visible = false


func _on_timer_4_timeout() -> void:
	four.visible = false

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
