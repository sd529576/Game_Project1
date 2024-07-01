extends RigidBody2D

var locking = false

var speed = 200

var new_nums = 53

var FIRE = false

var thrown = false

func _integrate_forces(state):
	if get_parent().name == "Projectile_attack_container":
		if new_nums == len(get_parent().get_children()): #  <- projectile attack container
			$AnimationPlayer.play("rotation")
			state.transform = Transform2D(0.0,get_parent().global_position)
		if len(get_parent().get_children()) == 53 and thrown == false:
			FIRE = true
			thrown = true
	if new_nums == 53 and FIRE == true:
		FIRE = false
		set_collision_mask_value(3,false)
		set_collision_mask_value(5,false)
		#num_box = 9
		new_nums += 1
		var random = RandomNumberGenerator.new()
		var random_num_x = random.randf_range(700,1300)
		var random_num_y = random.randf_range(2000,2300)
		apply_central_impulse(Vector2(random_num_x,-random_num_y))
