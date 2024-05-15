extends CharacterBody2D

var push_force = 80.0
var move_speed = 3.5

func _process(_delta):
	$AnimationPlayer.play("default")

func _physics_process(_delta):
	#await get_tree().create_timer(5).timeout
	if get_parent().Level_dict["Level2"] == true:
		position.x += move_speed
	
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
