extends AudioStreamPlayer

const level_music = preload("res://Resources/Music/BG_musik/BG_Musik_Wald_58.mp3")

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
		
	stream = music
	volume_db = Global.music_volume
	play()
	
func play_music_level():
	_play_music(level_music)


func stop_music():
	if playing:
		stop()  # Stoppt die Wiedergabe der Musik
	stream = null  # Entfernt den aktuellen Musikstream, damit es vollständig beendet ist
