extends Control

@onready var overworld = $"../.."

func _process(_delta):
	if Input.is_action_just_pressed("pause") and !Global.in_pause: 
		overworld.toggle_pause()

func _on_resume_pressed() -> void:
	overworld.toggle_pause()



func _on_save_and_exit_pressed() -> void:
	Global.save_game()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenen/menü.tscn")


func _on_settings_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenen/options_menü.tscn")
