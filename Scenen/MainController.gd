extends Node

# Variable, die angibt, ob ein Dialog läuft
var is_dialog_active = false

func _ready():
	# Pause-Modus dieses Nodes auf 'process' setzen, damit es im pausierten Modus funktioniert
	pause_mode = Node.PAUSE_MODE_PROCESS

func start_dialog():
	# Startet den Dialog
	is_dialog_active = true
	get_tree().paused = true  # Pausiert das Spiel
	$Dialogic.paues_mode = Node.PAUSE_MODE_PROCESS  # Dialogic soll weiterlaufen
	$Dialogic.start_dialog("IhrDialogName")  # Beispiel: Startet einen Dialog

func _on_dialogic_end():
	# Wird aufgerufen, wenn der Dialog beendet ist
	is_dialog_active = false
	get_tree().paused = false  # Spiel fortsetzen

func _input(event):
	# Eingaben filtern, wenn ein Dialog läuft
	if is_dialog_active:
		if event.is_action_pressed("ui_accept"):  # Eingabe für den Dialog (weiterklicken)
			$Dialogic.continue_dialog()
		event.consume()  # Blockiert alle anderen Eingaben
	else:
		pass  # Normales Verhalten, wenn kein Dialog aktiv ist
