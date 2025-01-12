extends Area2D

var talking =  false
var is_in_interact_area: bool = false

func _process(_delta):
	if is_in_interact_area:
		if Input.is_action_just_pressed("interact") and Global.bassist:
			Global.witch_position.x = -221 
			get_tree().change_scene_to_file("res://Scenen/subwaystation.tscn")
		elif Input.is_action_just_pressed("interact") and !Global.bassist and not talking:
			talking = true
			Dialogic.start("subway_entrance")


func _on_body_entered(body: Node2D) -> void:
	is_in_interact_area = true



func _on_body_exited(body: Node2D) -> void:
	talking = false  
	is_in_interact_area = false
