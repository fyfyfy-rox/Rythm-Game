extends CanvasLayer

func _ready():
	# Sichtbarkeit der ManaBar initialisieren
	$mana.visible = Global.manabar_visible

func _input(event):
	# Überprüfen, ob die Taste "manabar_anzeigen" gedrückt wurde
	if event.is_action_pressed("manaBar_anzeigen") and !Global.inputs_disabled:
		Global.manabar_visible = !Global.manabar_visible  # Toggle-Sichtbarkeit
		$mana.visible = Global.manabar_visible  # Sichtbarkeit der ManaBar anpassen
