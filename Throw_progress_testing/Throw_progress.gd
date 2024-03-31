extends ProgressBar

var held = false
func _process(delta):
	if Input.is_action_just_pressed("Throw"):# and get_parent().get_parent().get_node("Coin_ball_container/RigidBody2D").picked == true:
		held = true
	elif Input.is_action_just_released("Throw"):
		held = false
		
	if held == true:
		value += .05
	else:
		pass
