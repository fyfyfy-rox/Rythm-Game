extends AudioStreamPlayer2D

func _ready():
	self.stream.loop = true  # Aktiviert das Looping für den Stream
	play()  # Startet die Wiedergabe
