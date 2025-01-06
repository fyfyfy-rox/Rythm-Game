extends Control


func _on_volume_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/options_volume.tscn")
	

func _on_keybinds_pressed() -> void:
	pass # Replace with function body.
	

func _on_graphics_pressed() -> void:
	pass # Replace with function body.
	
	
func _on_back_pressed() -> void:
	# Speichere Einstellungen
	Global.save_settings()
	
	# Debugging für `get_tree()`
	if get_tree() == null:
		print("Fehler: get_tree() ist null!")
		return

	# Szene wechseln basierend auf der Pause-Variable
	if Global.in_pause_wald:
		print("Zurück in den Wald")
		get_tree().change_scene_to_file("res://Scenen/wald.tscn")
		Global.in_pause_wald = false
	elif Global.in_pause_subway:
		print("Zurück in die U-Bahn")
		get_tree().change_scene_to_file("res://Scenen/subwaystation.tscn")
		Global.in_pause_subway = false
	elif Global.in_pause_overworld:
		print("Zurück in die Overworld")
		get_tree().change_scene_to_file("res://Scenen/overworld_2.tscn")
		Global.in_pause_overworld = false
	else:
		print("Zurück ins Menü")
		get_tree().change_scene_to_file("res://Scenen/menü.tscn")
