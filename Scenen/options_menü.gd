extends Control


func _on_volume_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/options_volume.tscn")
	

func _on_keybinds_pressed() -> void:
	pass # Replace with function body.
	

func _on_graphics_pressed() -> void:
	pass # Replace with function body.
	
	
func _on_back_pressed() -> void:
	Global.save_settings()
	get_tree().change_scene_to_file("res://Scenen/menü.tscn")
