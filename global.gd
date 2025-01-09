extends Node

## GLOBAL ''

#Musicvolume
var music_volume: float = 0.05 # Lautstärke (0.0 bis 1.0)
var sfx_volume: float = 0.5    # Lautstärke für Soundeffekte
var master_volume: float = 0.5 # Lautstärke für Master
var current_music_scene: AudioStreamPlayer = null  # Aktueller AudioPlayer

#Hit or miss
var node_miss: bool = false

signal node_miss_changed

func update_node_miss(value: bool):
	if node_miss != value:  # Nur wenn der Wert sich tatsächlich ändert
		node_miss = value   # Ändere die Variable
		emit_signal("node_miss_changed", node_miss)  # Signal auslösen


# sensor 
var sensor_node_1 = 0;
var sensor_node_2 = 0;
var sensor_node_3 = 0;
var sensor_node_4 = 0;

var letzte_szene: String = ""

var tree_interacted = 0;

var first_game: bool = false

var mana = 0;
var inputs_disabled: bool = false

var in_pause_wald: bool = false
var in_pause_overworld: bool = false
var in_pause_subway: bool = false
var in_pause_rythm_wald: bool = false

var first_city_entered: bool = true
var in_rythm_game: bool = false

var manabar_visible = false

var witch_position: Vector2 = Vector2.ZERO  # Globale Position der Hexe
var witch_direction: Vector2 = Vector2(1, 0)  # Blickrichtung der Hexe

# Dictionary, das den Status jeder Szene speichert
var scene_states = {}

func save_settings():
	var settings_data = {
		"music_volume": music_volume,
		"sfx_volume": sfx_volume,
		"master_volume": master_volume
	}
	var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(settings_data))
		file.close()
		print("Einstellungen gespeichert!")


# Speichern des Spiels
func save_game():
	var save_data = {
		"player_position": [witch_position.x, witch_position.y],  # Spielerposition
		"player_direction": [witch_direction.x, witch_direction.y],  # Blickrichtung der Hexe
		"mana": mana,  # Mana des Spielers
		"current_scene": get_tree().current_scene.scene_file_path,  # Pfad zur aktuellen Szene
		"scene_states": scene_states,  # Speichert, ob Szenen bereits betreten wurden
	}

	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("Spielstand gespeichert!")



# Laden des Spiels
func load_game():
	# 1. Spielstände laden
	if FileAccess.file_exists("user://save_game.json"):
		var file = FileAccess.open("user://save_game.json", FileAccess.READ)
		if file:
			var file_content = file.get_as_text()
			var json_parser = JSON.new()
			var parse_result = json_parser.parse(file_content)
			file.close()

			if parse_result == OK:
				var save_data = json_parser.get_data()
				if typeof(save_data) == TYPE_DICTIONARY:
					# Spielerposition und Blickrichtung wiederherstellen
					witch_position = Vector2(save_data.get("player_position", [0, 0])[0], save_data.get("player_position", [0, 0])[1])
					witch_direction = Vector2(save_data.get("player_direction", [1, 0])[0], save_data.get("player_direction", [1, 0])[1])
					mana = save_data.get("mana", 0)

					# Szenenstatus wiederherstellen
					scene_states = save_data.get("scene_states", {})

					# Szene wechseln
					var current_scene_path = save_data.get("current_scene", "res://Scenes/DefaultScene.tscn")
					if ResourceLoader.exists(current_scene_path):
						get_tree().change_scene_to_file(current_scene_path)
						print("Szene erfolgreich geladen:", current_scene_path)
					else:
						print("Szene nicht gefunden:", current_scene_path)
				else:
					print("Fehler beim Laden: Ungültige JSON-Daten in save_game.json")
			else:
				print("Fehler beim Parsen der save_game.json:", json_parser.get_error_message())
	else:
		print("Kein Spielstand gefunden!")

# Settings loaden
func load_settings():
	# 2. Einstellungen laden
	if FileAccess.file_exists("user://settings.json"):
		var settings_file = FileAccess.open("user://settings.json", FileAccess.READ)
		if settings_file:
			var settings_content = settings_file.get_as_text()
			settings_file.close()

			# JSON-Parser-Instanz erstellen
			var json_parser = JSON.new()
			var parse_result = json_parser.parse(settings_content)

			if parse_result == OK:
				var settings_data = json_parser.get_data()
				if typeof(settings_data) == TYPE_DICTIONARY:
					# Werte aus dem Dictionary auslesen
					music_volume = settings_data.get("music_volume", 1.0)
					sfx_volume = settings_data.get("sfx_volume", 1.0)
					master_volume = settings_data.get("master_volume", 1.0)

					# Lautstärke auf die Audiobusse anwenden
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music_volume))
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx_volume))
					AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(master_volume))
					print("Einstellungen geladen!")
				else:
					print("Fehler: Ungültige JSON-Daten in settings.json")
			else:
				print("Fehler beim Parsen der settings.json:", json_parser.get_error_message())
	else:
		print("Keine Einstellungen gefunden, Standardwerte werden verwendet.")
