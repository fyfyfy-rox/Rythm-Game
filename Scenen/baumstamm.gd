extends Area2D
var entered = 0; 

func _on_timer_timeout() -> void:
	if (entered == 1):
		$E.visible = not $E.visible
		$E_off.visible = true
	if(entered  == 0):
		$E.visible = false
		$E_off.visible = false


func _on_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	entered = 1


func _on_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	entered = 0
