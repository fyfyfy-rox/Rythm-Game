extends Node

## GLOBAL ''

# sensor 
var sensor_node_1 = 0;
var sensor_node_2 = 0;
var sensor_node_3 = 0;
var sensor_node_4 = 0;

var tree_interacted = 0;

var first_game: bool = false

var mana = 0;
var inputs_disabled: bool = false

var first_city_entered: bool = true
var in_rythm_game: bool = false

var manabar_visible = false

var witch_position: Vector2 = Vector2.ZERO  # Globale Position der Hexe
var witch_direction: Vector2 = Vector2(1, 0)  # Blickrichtung der Hexe

# Dictionary, das den Status jeder Szene speichert
var scene_states = {}




# Speichern des Spiels
func save_game():
	var save_data = {
		"player_position": [witch_position.x, witch_position.y],  # Spielerposition
		"player_direction": [witch_direction.x, witch_direction.y],  # Blickrichtung der Hexe
		"mana": mana,  # Mana des Spielers
		"current_scene": get_tree().current_scene.scene_file_path,  # Pfad zur aktuellen Szene
		"scene_states": scene_states  # Speichert, ob Szenen bereits betreten wurden
	}

	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()
		print("Spielstand gespeichert!")




# Laden des Spiels
func load_game():
	var file = FileAccess.open("user://save_game.json", FileAccess.READ)
	if file:
		var file_content = file.get_as_text()
		var save_data = JSON.parse_string(file_content)
		file.close()

		if typeof(save_data) == TYPE_DICTIONARY:
			# Position und Mana wiederherstellen
			# Spielerposition und Blickrichtung wiederherstellen
			witch_position = Vector2(save_data.get("player_position", [0, 0])[0], save_data.get("player_position", [0, 0])[1])
			witch_direction = Vector2(save_data.get("player_direction", [1, 0])[0], save_data.get("player_direction", [1, 0])[1])
			mana = save_data.get("mana", 0)
			
			# Szenenstatus wiederherstellen
			scene_states = save_data.get("scene_states", {})  # Lade die Szenenstatus
			
			# Szene wechseln
			var current_scene_path = save_data.get("current_scene", "res://Scenes/DefaultScene.tscn")
			if ResourceLoader.exists(current_scene_path):
				get_tree().change_scene_to_file(current_scene_path)
				print("Szene erfolgreich geladen:", current_scene_path)
			else:
				print("Szene nicht gefunden:", current_scene_path)
		else:
			print("Fehler beim Laden: Ungültige JSON-Daten")
	else:
		print("Kein Spielstand gefunden!")
