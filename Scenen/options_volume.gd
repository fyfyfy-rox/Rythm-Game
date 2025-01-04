extends Control

@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var Music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var Master_BUS_ID = AudioServer.get_bus_index("Master")

func _ready() -> void:
	
	print("Master Volume beim Start:", Global.master_volume)
	print("Master Bus Volume DB beim Start:", AudioServer.get_bus_volume_db(Master_BUS_ID))

	# Lade gespeicherte Werte aus Global.gd
	$MarginContainer/VBoxContainer/GridContainer/MusicSlider.value = Global.music_volume
	$"MarginContainer/VBoxContainer/GridContainer/SFX Slider".value = Global.sfx_volume
	$MarginContainer/VBoxContainer/GridContainer/MasterSlider.value = Global.master_volume

	# Setze initiale Lautstärken
	AudioServer.set_bus_volume_db(Music_BUS_ID, linear_to_db(Global.music_volume))
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(Global.sfx_volume))
	AudioServer.set_bus_volume_db(Master_BUS_ID, linear_to_db(Global.master_volume))

func _on_music_slider_value_changed(value: float) -> void:
	Global.music_volume = value
	AudioServer.set_bus_volume_db(Music_BUS_ID,linear_to_db(value))
	AudioServer.set_bus_mute(Music_BUS_ID,value < 0.05)


func _on_sfx_slider_value_changed(value: float) -> void:
	Global.sfx_volume = value 
	AudioServer.set_bus_volume_db(SFX_BUS_ID,linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)


func _on_master_slider_value_changed(value: float) -> void:
	Global.master_volume = value
	AudioServer.set_bus_volume_db(Master_BUS_ID,linear_to_db(value))
	AudioServer.set_bus_mute(Master_BUS_ID, value < 0.05)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenen/options_menü.tscn")
