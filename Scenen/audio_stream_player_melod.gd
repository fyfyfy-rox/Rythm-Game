extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.node_miss_changed.connect(Callable(self, "_on_node_miss_changed"))


func _on_node_miss_changed(miss: bool):
	if miss:
		print("Miss erkannt. Musik wird stumm geschaltet.")
		volume_db = -80  # Melodie stumm
	else:
		print("Miss beendet. Musik wird wieder abgespielt.")
		volume_db = 0  # Lautstärke wiederherstellen
