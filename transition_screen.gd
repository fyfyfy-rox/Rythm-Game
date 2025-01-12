extends CanvasLayer

signal on_transition_finished

@onready var color_rect_black = $ColorRect_black
@onready var color_rect_white = $ColorRect_white
@onready var animation_player = $AnimationPlayer


func _ready():
	color_rect_white.visible = false 
	color_rect_black.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)


func _on_animation_finished(anim_name: String):
	if anim_name == "fade_to_white":
			on_transition_finished.emit()
			animation_player.play("fade_to_normal")
	elif anim_name == "fade_to_black":
			on_transition_finished.emit()
			animation_player.play("black_to_back")
	elif anim_name == "fade_to_normal":
			color_rect_white.visible = false
	elif anim_name == "black_to_back":
			color_rect_black.visible = false


func transition():
	color_rect_white.visible = true
	animation_player.play("fade_to_white")

func rythm_transition():
	color_rect_black.visible = true
	animation_player.play("fade_to_black")
