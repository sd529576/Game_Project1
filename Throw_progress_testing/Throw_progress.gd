extends ProgressBar

var max = 0
var held = false
func _process(delta):
	if Input.is_action_just_pressed("Charge_throws"):# and get_parent().get_parent().get_node("Coin_ball_container/RigidBody2D").picked == true:
		held = true
	elif Input.is_action_just_released("Charge_throws"):
		value = 0
		held = false
		
	if held == true:
		value += .05
		max = (max(max,value))
	else:
		pass
