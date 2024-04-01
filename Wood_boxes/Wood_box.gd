extends RigidBody2D

var speed = 200
func _physics_process(delta):
	if Input.is_action_just_pressed("Charge_throws"):
		var random = RandomNumberGenerator.new()
		var random_num = random.randf_range(100,1000)
		apply_central_impulse(Vector2(500,-random_num))
