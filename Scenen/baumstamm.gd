extends Area2D
var entered = 0; 
var once = true;


	

func _process(delta):
	if entered == 1:
		if Input.is_action_just_pressed("interact"):
			if once:
				once = false;
				Global.tree_interacted = 1


func _on_body_entered(body: Node2D) -> void:
	entered = 1


func _on_body_exited(body: Node2D) -> void:
	entered = 0
