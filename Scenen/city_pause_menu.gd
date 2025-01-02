extends Control

@onready var overworld = $"../.."

func _on_resume_pressed() -> void:
	overworld.toggle_pause()


func _on_save_and_exit_pressed() -> void:
	Global.save_game()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenen/menü.tscn")
