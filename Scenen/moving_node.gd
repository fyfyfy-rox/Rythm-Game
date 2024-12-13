extends Area2D
@onready var animp = $AnimationPlayer
var speed = 150
var sensor = 0


func _process(delta):
	
	position.x -= speed * delta
	position.y += speed * 0.2 * delta
	
	animp.play("play")
	if position.x < -400:
		queue_free()
	#Sensor or Pressed
	if sensor == 1: 
		# Add "Global" > new
		if Global.sensor_node_1 == 1:
			if  Input.is_action_just_pressed("ui_up"):
				queue_free()

		if Global.sensor_node_2 == 1:
			if  Input.is_action_just_pressed("ui_down"):
				queue_free()

		if Global.sensor_node_3 == 1:
			if  Input.is_action_just_pressed("ui_left"):
				queue_free()

		if Global.sensor_node_4 == 1:
			if  Input.is_action_just_pressed("ui_right"):
				queue_free()

func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 1

func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	sensor = 0
