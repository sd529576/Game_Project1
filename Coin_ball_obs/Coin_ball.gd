extends RigidBody2D

var picked = false
func _physics_process(delta):
	print(get_parent().get_parent().get_node("Player/ProgressBar").value)
	if picked == true:
		global_position = get_parent().get_parent().get_node("Player/Marker2D").global_position
	if Input.is_action_just_released("Charge_throws") and picked == true and get_parent().get_parent().get_node("Player/ProgressBar").max == 100:
		print("THROWING IT")
		picked = false
		apply_central_impulse(Vector2(-300,-800))
		get_parent().get_parent().get_node("Player/ProgressBar").max = 0
