extends RigidBody2D

func _physics_process(delta):
	if Input.is_action_just_pressed("run it"):
		print("runitworking?")
