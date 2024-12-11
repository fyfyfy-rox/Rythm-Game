extends Control

@onready var wald = $"../.."

func _on_resume_pressed() -> void:
	wald.toggle_pause()


func _on_save_and_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenen/menü.tscn")
