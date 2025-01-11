extends Control

@onready var rythm_game = $"../.."

func _on_resume_pressed() -> void:
	rythm_game.toggle_pause()

func _on_settings_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenen/options_menü.tscn")
