extends RigidBody2D

var picked = false
func _physics_process(delta):
	print(picked)
	if picked == true:
		global_position = get_parent().get_parent().get_node("Player/Marker2D").global_position
		
	if Input.is_action_just_pressed("Throw"):
		picked = false
		apply_central_impulse(Vector2(-300,-800))
