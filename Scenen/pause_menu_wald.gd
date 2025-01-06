extends Control

@onready var wald = $"../.."

func _process(_delta):
	if Input.is_action_just_pressed("pause") and !Global.in_pause_wald: 
		Global.in_pause_wald = true
		


func _on_resume_pressed() -> void:
	wald.toggle_pause()


func _on_save_and_exit_pressed() -> void:
	Global.save_game()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenen/menü.tscn")

func _on_settings_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenen/options_menü.tscn")
