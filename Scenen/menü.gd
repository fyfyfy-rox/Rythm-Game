extends Control

@onready var Witch_animation = $Witch

func _ready() -> void:
	Witch_animation.play("charge")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/wald.tscn")



func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/options_menü.tscn")



func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/test.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
