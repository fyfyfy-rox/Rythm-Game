extends Node2D


var talking = false
var is_in_chatting_area: bool = false

func _process(_delta):
	if is_in_chatting_area:
		if Input.is_action_just_pressed("interact") and not talking:
			talking = true
			if !Global.bassist and !Global.bass_done:
				Dialogic.start("city_gramps")
			elif Global.bass_done and !Global.bassist:
				Dialogic.start("gramps_abkürzung")
			else:
				Dialogic.start("gramps_alt")


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Body entered:", body)
	if body.is_in_group("player"):
		is_in_chatting_area = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		talking = false
		is_in_chatting_area = false
