extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

# parameters/Idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameter(starting_direction)

func _physics_process(_delta: float) -> void:
	if !Global.inputs_disabled:
		var input_direction = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			0
		)
		player_falling()
		move_and_slide()
		update_animation_parameter(input_direction)
		velocity = input_direction * move_speed
		move_and_slide()
		pick_new_state()

func player_falling():
	if !is_on_floor():
		velocity.y += 2 * move_speed

#Changes character dicetion of animation
func update_animation_parameter(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
