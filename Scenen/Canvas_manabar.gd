extends CanvasLayer

@onready var max_mana = $max_mana

func _ready():
	# Sichtbarkeit der ManaBar initialisieren
	$mana.visible = Global.manabar_visible
	if(Global.mana == 1000):
		max_mana.visible = true
	else:
		max_mana.visible = false

func _input(event):
	# Überprüfen, ob die Taste "manabar_anzeigen" gedrückt wurde
	if event.is_action_pressed("manaBar_anzeigen") and !Global.inputs_disabled:
		Global.manabar_visible = !Global.manabar_visible  # Toggle-Sichtbarkeit
		$mana.visible = Global.manabar_visible  # Sichtbarkeit der ManaBar anpassen
