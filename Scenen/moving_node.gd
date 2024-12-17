extends Area2D
@onready var animp = $AnimationPlayer
var speed = 185
var sensor = 0

func _process(delta):
	
	position.x -= speed * delta
	
	animp.play("play")
	if position.x < -400:
		queue_free()
	#Sensor or Pressed
	if sensor == 1: 
		# Add "Global" > new
		if Global.sensor_node_1 == 1:
			if  Input.is_action_just_pressed("1"):
				queue_free()

		if Global.sensor_node_2 == 1:
			if  Input.is_action_just_pressed("2"):
				queue_free()

		if Global.sensor_node_3 == 1:
			if  Input.is_action_just_pressed("3"):
				queue_free()

		if Global.sensor_node_4 == 1:
			if  Input.is_action_just_pressed("4"):
				queue_free()

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 1

func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 0
	queue_free()
