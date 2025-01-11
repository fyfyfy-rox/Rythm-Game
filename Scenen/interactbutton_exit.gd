extends Area2D
var entered = 0; 

func _on_timer_timeout() -> void:
	if (entered == 1):
		$E.visible = not $E.visible
		$E_off.visible = true
	if(entered  == 0):
		$E.visible = false
		$E_off.visible = false

func _process(_delta):
	if (entered == 1):
		if Input.is_action_just_pressed("interact"):
			Global.witch_position.x = 1550
			Global.witch_position.y = 760
			get_tree().change_scene_to_file("res://Scenen/overworld_2.tscn")

func _on_body_entered(body: Node2D) -> void:
	entered = 1


func _on_body_exited(body: Node2D) -> void:
	entered = 0
