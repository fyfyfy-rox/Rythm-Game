extends Area2D
var entered = 0; 
var in_chat = false 
func _on_timer_timeout() -> void:
	if (entered == 1):
		$E.visible = not $E.visible
		$E_off.visible = true
	if(entered  == 0):
		$E.visible = false
		$E_off.visible = false

func _process(_delta):
	if (entered == 1):
		if Input.is_action_just_pressed("interact") and not in_chat:
			in_chat = true
			Dialogic.start("res://addons/dialogic/Dialoge/Brunnen.dtl")

func _on_body_entered(body: Node2D) -> void:
	entered = 1


func _on_body_exited(body: Node2D) -> void:
	entered = 0
	in_chat = false
