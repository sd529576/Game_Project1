extends Node2D
var monster = preload("res://monster2/monster2.tscn")
var monster3 = preload("res://Monster3/Monster3.tscn")
var boss_slime = preload("res://boss_slime/king_slime_boss.tscn")
var baby_mob = preload("res://Baby_slimes/level_1_baby_mob.tscn")
var coin = preload("res://Coins/coins.tscn")
var phoenix = preload("res://phoenix/phoenix.tscn")
var fire_ball = preload("res://Fire_ball/Fire_ball.tscn")
var blue_flame = preload("res://blue_fire/Blue_flame.tscn").instantiate()
var Reaper_knife = preload("res://Reaper_Knife/Reaper_knife.tscn").instantiate()
var spear = preload("res://Spear_obstacle/Spear.tscn")
var Level_dict = {"Level1":true,"Level2":false,"Level3":false}
var number = 1
var phoenix_skill_num = 0
var paused = false
var pressed = false
var door_entered = false
var monster_num = 50
var boss_occurance = false
var going_down = false
var random = RandomNumberGenerator.new()
var phase = 3
var boss1 = boss_slime.instantiate()
var available_blocks = 0
var timer_pressed = false
signal spear_firing
func _ready():
	$Main_sound_container/In_game_music.play()
	boss1.boss_function_called.connect(Level1_baby_spawn)
	$"Level Indicator".text = ("Slimy Forest")
	$Main_Timer_container/Level_Indicator_timer.start()
	$Main_Timer_container/Round_timer.start()
func game_over():
	if $Player.health == 0 and $Player.death_once == false:
		$Player.death_once = true
		get_node("Player").get_node("AnimatedSprite2D").play("Death")
		get_node("Main_Timer_container/second_delay_after_death_timer").start()
func Level_changes():
	if Level_dict["Level2"] == true and len($Monster_container.get_children()) == 0:
		get_node("Level2_Screen/Timer").set_autostart(true)
		get_node("Level2_Screen/Timer").start()
		Level_dict["Level1"] = false
		$Level2_Screen.make_current()
		$Player.set_collision_layer_value(1,false)
		$Player.set_collision_mask_value(1,false)
		$Player.set_collision_layer_value(4,false)
		$Player.set_collision_mask_value(4,false)
		$Player.set_collision_layer_value(3,true)
		$Player.set_collision_mask_value(3,true)
		$Player/RemoteTransform2D.set_remote_node("Level2_Screen")
	"""
	if monster_num <= 40:
		for i in $Monster_container.get_children():
			i.set_collision_layer_value(2,false)
			i.set_collision_mask_value(2,false)
			i.set_collision_layer_value(3,true)
			i.set_collision_mask_value(3,true)
		$Levels/Level1_TileMap.hide()
		$Levels/Level2_TileMap.show()
		$Ladder.hide()
		$Player/RemoteTransform2D.position.y = -150
		"""
func _physics_process(_delta):
	game_over()
func _process(_delta):
	if $Reaper/Reaper_knife/Knife.frame == 20:
		$Reaper/Reaper_knife.hide()
		#$Reaper_knife/AnimatedSprite2D.play("default")
	blue_flame_timer()
	if going_down == true and $Player.position.y < 700:
		$Player.set_collision_layer_value(1,false)
		$Player.set_collision_mask_value(1,false)
		await get_tree().create_timer(0.2).timeout
		$Player.set_collision_layer_value(1,true)
		$Player.set_collision_mask_value(1,true)
		going_down = false
	Level1_Boss_spawn()
	Level_changes()
	monster_death()
	if Input.is_action_just_pressed("Paused"):
		pause_screen()
	$Player_stat.text = ("Player Health:" + str($Player.health) +"\nCoins:" + str($Player.coins))
	#$Round_time_left.text = (str(snappedf($Round_timer.time_left,0.01)))
	if door_entered == true and Input.is_action_just_pressed("Up"):
		$Main_Timer_container/Teleport_timer.start()
		$Main_sound_container/Teleport_sound.play()
	if Input.is_action_just_pressed("Kill"):
		for i in $Monster_container.get_children():
			i.health -= 100
		for i in $Baby_slime_container.get_children():
			i.health -= 100
	if Input.is_action_just_pressed("check") and number == 1 and phoenix_skill_num >0:
		Instantiate(phoenix,get_node("Node2D").position.x,get_node("Node2D").position.y,0,0,"Testing_container")
		Instantiate(fire_ball,get_node("Node2D").position.x+100,get_node("Node2D").position.y+100,0,0,"Testing_container")
		timer_pressed = false
		number = 0
		phoenix_skill_num -= 1
func Level1_monster_spawn():
	random = -(randi() % 1100)
	Instantiate(monster,random,300,0,0,"Monster_container")
func Level2_monster_spawn():
	random = -(randi() % 1100)
	Instantiate(monster3,random,1200,0,0,"Monster_container")

func Spear_rain():
	random = -(randi() % 1100)
	Instantiate(spear,random,95,0,0,"Spear_container")

func Level1_baby_spawn():
	if len($Baby_slime_container.get_children()) < 10 and phase > 0:
		Instantiate(baby_mob,boss1.position.x - 150,boss1.position.y,-300,0,"Baby_slime_container")
		Instantiate(baby_mob,boss1.position.x +150,boss1.position.y,300,0,"Baby_slime_container")
		Instantiate(baby_mob,boss1.position.x,boss1.position.y -124,0,-500,"Baby_slime_container")
		Instantiate(baby_mob,boss1.position.x + 139,boss1.position.y - 72,500,-500,"Baby_slime_container")
		Instantiate(baby_mob,boss1.position.x - 139,boss1.position.y - 72,-500,-500,"Baby_slime_container")
		phase = phase -1
func Level1_Boss_spawn():
	if monster_num <= 40 and boss_occurance == false:
		boss1.position.x = -907
		boss1.position.y = 489
		get_node("Monster_container").add_child(boss1)
		boss_occurance = true
		
func monster_death():
	if len($Monster_container.get_children()) > 0:
		for i in $Monster_container.get_children():
			if i.health <= 0 and i.name != "King_slime_boss":
				monster_num -= 1
				i.queue_free()
				Instantiate(coin,i.position.x,i.position.y,0,0,"Coin_bag")
				$Monster_sound_container/Slime_death_sound.play()
			elif i.name == "King_slime_boss" and i.health == 0:
				i.queue_free()
				$Main_Timer_container/Round_timer.paused = true
			elif monster_num <= 40 and i.name != "King_slime_boss" and Level_dict["Level1"] == true:
				i.queue_free()
	if len($Baby_slime_container.get_children()) > 0:
		for i in $Baby_slime_container.get_children():
			if i.health <= 0:
				i.queue_free()
				Instantiate(coin,i.position.x,i.position.y,0,0,"Coin_bag")
func _on_monster_spawn_timer_timeout():
	if paused == false and Level_dict["Level1"] == true:
		Level1_monster_spawn()
	elif paused == false and Level_dict["Level2"] == true:
		Level2_monster_spawn()

func pause_screen():
	if !paused:
		if Level_dict["Level1"] == true:
			#Engine.time_scale = 0
			if len($Monster_container.get_children())!= 1:
				for i in $Monster_container.get_children():
					i.set_physics_process(false)
					i.get_node("Monster2_jump_timer").paused = true
			if len($Baby_slime_container.get_children())!= 1:
				for i in $Baby_slime_container.get_children():
					i.set_physics_process(false)
			$Main_Menu.show()
			$Player_stat.hide()
			$Player.hide()
			$Option_Menu_Main.hide()
			$Main_sound_container/In_game_music.stream_paused = true
			$Merchant_Setting_screen.make_current()
			$Reaper/Death_sentence.paused = true
		
		
		#$Player.get_node("Player_stat").hide()
		#$Player.get_node("SpritesheetFinal").hide()
	elif paused:
		if Level_dict["Level1"] == true:
			if len($Monster_container.get_children())!= 1:
				for i in $Monster_container.get_children():
					i.set_physics_process(true)
					i.get_node("Monster2_jump_timer").paused = false
			if len($Baby_slime_container.get_children())!= 1:
				for i in $Baby_slime_container.get_children():
					i.set_physics_process(true)
			$Monster_container.show()
			$Main_Menu.hide()
			$Option_Menu_Main.show()
			$Merchant_screen.hide()
			$Player_stat.show()
			$Player.show()
			$Level1_Screen.make_current()
			$Reaper/Death_sentence.paused = false
	paused = !paused


func _on_resume_btn_pressed():
	paused = paused
	pause_screen()
	$Levels/Level1_TileMap.visible = true
	$Level1_Screen.make_current()
	$Main_sound_container/In_game_music.stream_paused = false
	$Merchant_screen.hide()
func _on_merchant_btn_pressed():
	#Engine.time_scale = 0
	
	#$Monster_container.pause()
	$Monster_container.hide()
	$Main_Menu.hide()
	$Player_stat.hide()
	$Player.hide()
	$Main_sound_container/In_game_music.stream_paused = true
	$Merchant_screen.show()
	$Merchant_Setting_screen.make_current()
	$Main_sound_container/Merchant_rain_music.play()
	# the reason that we need these nodes to be individual hidden is because merchant screen is part of the player node
	
func _on_exit_btn_pressed():
	get_tree().quit()


func _on_option_btn_pressed():
	$Option_Menu_Main.show()
	$Main_Menu.hide()
	$Merchant_Setting_screen.make_current()
	

func _on_door_body_entered(body):
	if body.is_in_group("Climber"):
		door_entered = true

func _on_timer_timeout():
	random.randomize()
	var random_door_node = get_node("multiple_door_container").get_children()[randi() % len(get_node("multiple_door_container").get_children())-1]
	$Player.position.x = random_door_node.position.x
	$Player.position.y = random_door_node.position.y
	door_entered = false

func _on_back_btn_2_pressed():
	_on_resume_btn_pressed()
	$Level1_Screen.make_current()

func _on_modulate_message_timer_timeout():
	$Level2_starting_message.modulate.a = $Level2_starting_message.modulate.a -0.1

func _on_round_timer_timeout():
	pass
	
func Instantiate(target,x_position:int,y_position:int,x_velocity:int,y_velocity:int,source:String):
	var target_mob = target.instantiate()
	target_mob.position.x = x_position
	target_mob.position.y = y_position
	target_mob.velocity.x = x_velocity
	target_mob.velocity.y = y_velocity
	
	get_node(source).add_child(target_mob)


func _on_level_indicator_timer_timeout():
	if $"Level Indicator".modulate.a > 0:
		$"Level Indicator".modulate.a = $"Level Indicator".modulate.a - 0.1
	"""
	if $Candidate1.modulate.a >0:
		$"Candidate1".modulate.a = $Candidate1.modulate.a - 0.1
 """


func blue_flame_timer():
	for i in $Testing_container.get_children():
		if i.name == blue_flame.name and timer_pressed == false:
			$Main_Timer_container/Blue_flame_duration.start()
			timer_pressed = true
	
func _on_blue_flame_duration_timeout():
	get_node("Testing_container/Blue_flame").queue_free()
	get_node("Testing_container/phoenix").queue_free()
	number = 1


func _on_death_sentence_timeout():
	if Level_dict["Level1"] == true:
		$Candidate1.show()
		$Reaper/Reaper_knife.show()
		$Main_sound_container/shadow.play()
		$Main_sound_container/Knife_slice_ready.play()
		$Reaper/Reaper_knife/Knife.play("default")
		$Reaper/Reaper_knife/Inverted_knife.play("default")
		$Reaper/death.start()
		$Reaper/Slicing_timer.start()
func _on_death_timeout():
	if $Candidate1.modulate.a >0:
		$Candidate1.modulate.a = $Candidate1.modulate.a - 0.05
	elif $Candidate1.modulate.a < 0:
		$Candidate1.hide()
		$Candidate1.modulate.a = 1
		$Main_Timer_container/Darkness_container.start()

func _on_slicing_timer_timeout():
	$Main_sound_container/Knife_slicing.play()


func _on_spear_rain_timeout():
	for i in range(10):
		Spear_rain()
		spear_firing.emit()


func _on_darkness_container_timeout():
	$Darkness.visible = true
	$Player/PointLight2D.visible = true
	$Main_Timer_container/darkness_reset.start()


func _on_darkness_reset_timeout():
	$Darkness.visible = false
	$Player/PointLight2D.visible = false