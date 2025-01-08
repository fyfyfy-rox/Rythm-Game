extends Area2D

@onready var animp = $AnimationPlayer
@onready var miss_sound = $"../../AudioStreamPlayer_failsound"
@export var mana_inc = 1
var sensor = 0

func _process(delta):
	
	if sensor == 1:
		if Input.is_action_just_pressed("2"):
			Global.mana += mana_inc
			animp.play("hit")
			Global.update_node_miss(false)
			
	if sensor == 0:
		if Input.is_action_just_pressed("2"):
			if(Global.mana > 0):
				Global.mana -= mana_inc
			animp.play("miss")
			miss_sound.play()
			Global.update_node_miss(true)

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 1
	Global.sensor_node_2 = 1


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 0
	Global.sensor_node_2 = 0
