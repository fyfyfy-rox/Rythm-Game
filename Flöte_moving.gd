extends Sprite2D

var flip = 1

func _process(delta):
	if(flip == 1):
		position.y +=  0.05 *(position.y -800) * delta
		if(position.y <= -200):
			flip = 0
	if(flip == 0):
		position.y +=  -0.05 * (position.y -750) * delta
		if(position.y >= -150):
			flip = 1
