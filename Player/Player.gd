extends CharacterBody2D
@export var move_speed : float = 200
@export var climb_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0,1)
var input_handler = false
var jump_velocity = -600.0
var push_force = 80.0
var gravity = 3000
var health = 50
var state_x = 0
var death_once = false
var bullet_list = []
var bulletpath = preload("res://Attack_image//attack_bullet.tscn")
var bulletpath2 = preload("res://Attack_image//attack_bullet_2.tscn")
var bulletpath3 = preload("res://Attack_image//attack_bullet_3.tscn")
var rock = preload("res://Rock_attack_image/Rock.tscn")
var grav_only_stairs = false
var coins = 0
var upgrade_numbers = 3
var upgrade_enhanced_numbers = 3
var velocity_dif = 0
var Ladder_list = {}
var smallest = [100000]
var hold_input = false
var jump_count = 0
var max_jump = 2
var third_attack = false
var attack_count = 3
var sound_path = AudioStreamPlayer2D
@onready var Monster2 = preload("res://monster2/monster2.tscn").instantiate()
@export var on_ladder = false
signal Projectile_direction

func _process(_delta):
	if Input.is_action_just_pressed("Coin_copy"):
		coins += 100
	var input_direction = Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	)
	moving(input_direction.x)
	jump(input_direction.x)
func _physics_process(delta):
	if is_on_floor():
		jump_count = 0
	going_down()
	if not is_on_floor() and grav_only_stairs == false:
		velocity.y += gravity*delta
		
	elif on_ladder == false:
		grav_only_stairs = false
	#Ladder_climb()
	player_ground_detection()
	# this condition was applied to stop the player movement when you either click esc btn or resume btn(singal was connected to the main node, which had to use music content that was separated.)
	if get_parent().paused == false or get_parent().get_node("Main_sound_container/In_game_music").stream_paused == false:
		shield_activation()
		attack_animation()
		player_attacked()
		Attack_timer()
	else:
		pass
	
	if Input.is_action_just_pressed("Build") and get_parent().available_blocks != 0:
		get_parent().available_blocks -= 1
		var b = rock.instantiate()
		get_parent().get_node("bulletContainer").add_child(b)
		b.position.x = position.x
		b.position.y = position.y + 20
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal()*push_force)
func player_ground_detection():
	if velocity.y < 0:
		velocity_dif += velocity.y
	if velocity.y == 0 and velocity_dif <0:
		$Player_sound_container/hitting_ground.play()
		velocity_dif = 0
func moving(x_value):
	if x_value == 1  and $AnimationPlayer.current_animation != "Attack" and $AnimationPlayer.current_animation != "charge_attack" and $AnimationPlayer.current_animation != "attacked" and $AnimationPlayer.current_animation != "Jump" and $AnimationPlayer.current_animation != "Attack_enhanced_Down":
		velocity.x = move_speed
		$Player_body.scale.x = 1.75
		$AnimationPlayer.play("Walk_new")
		state_x = 1
	if x_value == -1 and $AnimationPlayer.current_animation != "Attack" and $AnimationPlayer.current_animation != "charge_attack" and $AnimationPlayer.current_animation != "attacked" and $AnimationPlayer.current_animation != "Jump" and $AnimationPlayer.current_animation != "Attack_enhanced_Down":
		state_x = -1
		velocity.x = -move_speed
		$Player_body.scale.x = -1.75
		$AnimationPlayer.play("Walk_new")
	if x_value == 0:
		velocity.x = 0
		if state_x == -1 and $AnimationPlayer.current_animation != "Attack" and $AnimationPlayer.current_animation != "charge_attack" and $AnimationPlayer.current_animation != "attacked" and $AnimationPlayer.current_animation != "Jump" and $AnimationPlayer.current_animation != "Attack_enhanced_Down":
			$Player_body.scale.x = -1.75
			$AnimationPlayer.play("Idle_new")
		if state_x == 1  and $AnimationPlayer.current_animation != "Attack" and $AnimationPlayer.current_animation != "charge_attack" and $AnimationPlayer.current_animation != "attacked" and $AnimationPlayer.current_animation != "Jump" and $AnimationPlayer.current_animation != "Attack_enhanced_Down":
			$Player_body.scale.x = 1.75
			$AnimationPlayer.play("Idle_new")
func going_down():
	if Input.is_action_just_pressed("Down"):
		hold_input = true
	if Input.is_action_just_released("Down"):
		hold_input = false
		
	if hold_input == true and Input.is_action_just_pressed("jump"):
		get_parent().going_down = true
func jump(x_value):
	sound_path = $Player_sound_container/Jump_sound
	if x_value == 1:
		velocity.x = move_speed
		if Input.is_action_just_pressed("jump") and hold_input == false and jump_count < max_jump:
			velocity.y = jump_velocity
			$AnimationPlayer.play("Jump")
			player_sound_play(sound_path)
			jump_count += 1
	elif x_value == -1:
		velocity.x = -move_speed
		if Input.is_action_just_pressed("jump") and hold_input == false and jump_count < max_jump:
			velocity.y = jump_velocity
			$Player_body.scale.x = -1.75
			$AnimationPlayer.play("Jump")
			player_sound_play(sound_path)
			jump_count += 1
	elif x_value == 0:
		if Input.is_action_just_pressed("jump") and hold_input == false and jump_count < max_jump:
			velocity.y = jump_velocity
			$AnimationPlayer.play("Jump")
			player_sound_play(sound_path)
			jump_count += 1
func attack_animation():
	if input_handler == false:
		#Enhanced Up
		if Input.is_action_just_pressed("Attack") and state_x == -1 and upgrade_enhanced_numbers == 3:
			$Player_body.scale.x = -1.75
			$AnimationPlayer.play("Attack")
		if Input.is_action_just_pressed("Attack") and state_x == 1 and upgrade_enhanced_numbers == 3:
			$Player_body.scale.x = 1.75
			$AnimationPlayer.play("Attack")
		#Enhanced down
		if Input.is_action_just_pressed("Attack") and state_x == -1 and upgrade_enhanced_numbers == 2:
			$Player_body.scale.x = -1.75
			$AnimationPlayer.play("Attack_enhanced_Down")
		if Input.is_action_just_pressed("Attack") and state_x == 1 and upgrade_enhanced_numbers == 2:
			$Player_body.scale.x = 1.75
			$AnimationPlayer.play("Attack_enhanced_Down")
			
		if Input.is_action_just_pressed("Charged_attack") and state_x == -1:
			$Player_body.scale.x = -1.75
			$AnimationPlayer.play("charge_attack")
		if Input.is_action_just_pressed("Charged_attack") and state_x == 1:
			$Player_body.scale.x = 1.75
			$AnimationPlayer.play("charge_attack")
			
	# limiting the attack animation to occur when the shield is activated.
	elif input_handler == true:# and Input.is_action_just_pressed("Shield_on_off"):
		pass
func player_attacked():
	if get_node("Attacked_collision").hurt == true and health > 0:
		$Player_sound_container/Hurt_sound.play()
		health = health - 5
		get_node("Attacked_collision").hurt = false
		#velocity.y = $Attacked_collision.attack_bounce_direction * 3000
		velocity.x = $Attacked_collision.attack_bounce_direction * 3000
func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Game_over/game_over.tscn")
	
func Attack_timer():
	if Input.is_action_just_pressed("Attack"):
		$Attack_Timer.start()

func shoot():
	if third_attack == true:
		attack_count = 3
		third_attack = false
		var b = bulletpath.instantiate()
		get_parent().get_node("bulletContainer").add_child(b)
		b.position = $Muzzle.global_position
		if state_x == -1:
			b.facing_direction = -1
			b.scale.x = -1
			$Muzzle.position.x = 3
			$Muzzle.position.y = 0
		elif state_x == 1:
			b.facing_direction = 1
			b.scale.x = 1
			$Muzzle.position.x = 50
			$Muzzle.position.y = 0
	elif third_attack == false:
		attack_count -=1
		var rng = RandomNumberGenerator.new()
		var random_num = rng.randi_range(0,10)
		if attack_count <2:
			third_attack = true
		#this must be 50percent chance of getting the second attack to occur
		elif attack_count == 2 and random_num % 2 == 0 and upgrade_numbers == 2:
			third_attack = true
func shoot_enhanced_bottom():
	if third_attack == true:
		attack_count = 3
		third_attack = false
		var b = bulletpath.instantiate()
		get_parent().get_node("bulletContainer").add_child(b)
		#bullet_list.append(b)
		b.position = $Muzzle.global_position
		var c = bulletpath2.instantiate()
		get_parent().get_node("bulletContainer").add_child(c)
		c.position = $Muzzle.global_position
		if state_x == -1:
			b.facing_direction = -1
			b.scale.x = -1
			c.facing_direction = -1
			c.scale.x = -1
			$Muzzle.position.x = 3
			$Muzzle.position.y = 0
		elif state_x == 1:
			b.facing_direction = 1
			b.scale.x = 1
			c.facing_direction = 1
			c.scale.x = 1
			$Muzzle.position.x = 50
			$Muzzle.position.y = 0
		
	elif third_attack == false:
		attack_count -=1
		if attack_count <2:
			third_attack = true
func shoot_time_out():
	pass
	
	"""
	if input_handler == false:
		if upgrade_enhanced_numbers == 3:
			shoot()
		elif upgrade_enhanced_numbers == 2:
			shoot_enhanced_bottom()
		elif upgrade_enhanced_numbers <= 1:
			shoot_enhanced_top()
		$Attack_Timer.stop()
		#$Player_sound_container/attack_sound.play()
	# limiting the attack animation to occur when the shield is activated.
	elif input_handler == true:# and Input.is_action_just_pressed("Shield_on_off"):
		pass
		"""
"""
func Ladder_climb():
	if Input.is_action_just_pressed("Up") and on_ladder == true:
		for i in get_parent().get_node("Ladder_container").get_children():
			if (abs(i.position.x - position.x)) < 10:
				position.x = i.position.x
				
		#input_direction.x = 0
		grav_only_stairs = true
		velocity.y = -climb_speed
		$SpritesheetFinal.visible = false
		$AnimatedSprite2D.visible = true
		$AnimatedSprite2D.play("Climb_up")
"""
func shield_activation():
	if get_parent().get_node("Merchant_screen").shield_activation == true:
		if Input.is_action_just_pressed("Shield_on_off"):
			input_handler = true
			var shield = preload("res://Sphere_shield/Shield.tscn").instantiate()
			add_child(shield)
		if Input.is_action_just_released("Shield_on_off"):
			input_handler = false
			if $Shield:
				$Shield.queue_free()
			else:
				pass

func player_sound_play(sound):
	sound.play()


func _on_visible_on_screen_notifier_2d_screen_exited():
	health = 0
