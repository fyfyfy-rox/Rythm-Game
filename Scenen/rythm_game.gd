extends Node2D

const NODE = preload("res://Scenen/moving_Node.tscn")
@onready var Witch_animation = $Witch

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) 
	Witch_animation.play("charge")
	Global.tree_interacted == 0;

func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	if event.type == 144:
		if channel.number == 2:
			var node = NODE.instantiate()
			node.position = $Positions/Position1.global_position
			get_parent().add_child(node)
		if channel.number == 3:
			var node = NODE.instantiate()
			node.position = $Positions/Position2.global_position
			get_parent().add_child(node)
		if channel.number == 4:
			var node = NODE.instantiate()
			node.position = $Positions/Position3.global_position
			get_parent().add_child(node)
		if channel.number == 5:
			var node = NODE.instantiate()
			node.position = $Positions/Position4.global_position
			get_parent().add_child(node)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenen/wald.tscn")
