extends Node2D

const NODE = preload("res://Scenen/moving_Node.tscn")


func _on_midi_player_midi_event(channel: Variant, event: Variant) -> void:
	#if event == 144:
		if channel.number == 2:
			var node = NODE.instantiate()
			get_parent().add_child(node)
			#node.position = $Positions/Position1
