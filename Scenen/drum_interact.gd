extends Area2D

var is_in_chatting_area = false


func _process(_delta):
	if is_in_chatting_area:
		if Input.is_action_just_pressed("interact"):
			TransitionScreen.rythm_transition()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file("res://Scenen/Rythm_Drum.tscn")
	

func _on_body_entered(body: Node2D) -> void:
	is_in_chatting_area = true



func _on_body_exited(body: Node2D) -> void:
	is_in_chatting_area = false
