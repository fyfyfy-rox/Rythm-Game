extends Area2D

var is_in_interact_area: bool = false

func _process(_delta):
	if is_in_interact_area:
		if Input.is_action_just_pressed("interact"):
			get_tree().change_scene_to_file("res://Scenen/subwaystation.tscn")


func _on_body_entered(body: Node2D) -> void:
	is_in_interact_area = true



func _on_body_exited(body: Node2D) -> void:
	is_in_interact_area = false
