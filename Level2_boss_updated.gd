extends CharacterBody2D

var push_force = 80.0
var wood_box = preload("res://Wood_boxes/Wood_box.tscn")
@export var num_box = 0
var box = preload("res://Wood_boxes/Wood_box.tscn")
var occured = false
var move_speed = 2.0

func _process(_delta):
	"""
	print(num_box)
	print(len(get_parent().get_node("Wood_box_container").get_children()))
	print(len(get_node("Projectile_attack_container").get_children()))
	$AnimationPlayer.play("default")
	"""
	if occured == false:
		if len(get_parent().get_node("Wood_box_container").get_children()) == 0:
			print("hello?")
			for i in num_box:
				var new_box = box.instantiate()
				new_box.set_collision_layer_value(3,false)
				$Projectile_attack_container.add_child(new_box)
			num_box = 0
			occured = true
			
func _physics_process(_delta):
	#await get_tree().create_timer(5).timeout
	if get_parent().Level_dict["Level2"] == true:
		position.x += move_speed
	
	move_and_slide()
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
			
	"""
	if num_box == -1:
		for i in get_node("Projectile_attack_container").get_children():
			#i.global_position = get_node("Projectile_attack_container").global_position
			if Input.is_action_just_pressed("Charge_throws"):
				#num_box = 9
				var random = RandomNumberGenerator.new()
				var random_num = random.randf_range(100,1000)
				i.apply_central_impulse(Vector2(400,-random_num))
				"""
