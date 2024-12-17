extends Area2D

@onready var animp = $AnimationPlayer
var sensor = 0

func _process(delta):
	
	if sensor == 1:
		if Input.is_action_just_pressed("4"):
			Global.mana += 1
			animp.play("hit")
			
	if sensor == 0:
		if Input.is_action_just_pressed("4"):
			if(Global.mana > 0):
				Global.mana -= 1
			animp.play("miss")

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 1
	Global.sensor_node_4 = 1


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 0
	Global.sensor_node_4 = 0
