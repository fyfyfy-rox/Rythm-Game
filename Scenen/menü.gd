extends Control

@onready var Witch_animation = $Witch
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var Master_BUS_ID = AudioServer.get_bus_index("Master")

func _ready() -> void:
	Global.load_settings()
	Witch_animation.play("charge")
	AudioPlayer_Menu.play_music_level()
	
	# Setze initiale Lautstärken
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(Global.music_volume))
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(Global.sfx_volume))
	AudioServer.set_bus_volume_db(Master_BUS_ID, linear_to_db(Global.master_volume))
	


func _on_play_pressed() -> void:
	if FileAccess.file_exists("user://save_game.json"):
		print("Spielstand gefunden. Wird geladen...")
		Global.load_game()
		Global.load_settings()
		
		
	else:
		print("Kein Spielstand gefunden. Es wird einer erstellt.")
		get_tree().change_scene_to_file("res://Scenen/wald.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/options_menü.tscn")



func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/Credits.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_new_game_pressed() -> void:
	Global.delete_save()
	get_tree().change_scene_to_file("res://Scenen/wald.tscn")
