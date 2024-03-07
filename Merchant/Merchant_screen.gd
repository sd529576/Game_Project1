extends Node2D

@onready var player = get_parent().get_node("Player")
@onready var main = get_parent().get_parent().get_node("Main")
var shield_activation = false
func _on_button_pressed():
	get_parent()._on_resume_btn_pressed()
	get_parent().get_node("Main_sound_container/Merchant_rain_music").stream_paused = true
	"""
	Engine.time_scale = 1
	get_parent().get_node("Main_Menu").hide()
	get_parent().get_node("Monster_container").show()
	get_parent().get_node("RichTextLabel").show()
	get_parent().get_node("Player").show()
	get_parent().get_node("Level1/Level1 TileMap").visible = true
	hide()
"""


func _on_enhanced_attack_btn_mouse_entered():
	$Skill_name.text = ("Friends")
	$Description.text = ("3rd Attack fires on one additional direction")


func _on_enhanced_attack_btn_mouse_exited():
	$Skill_name.text = ("")
	$Description.text = ("")



func _on_attack_speed_btn_mouse_entered():
	$Skill_name.text = ("Cry")
	$Description.text = ("Attack delay gets reduced")


func _on_attack_speed_btn_mouse_exited():
	$Skill_name.text = ("")
	$Description.text = ("")


func _on_block_addition_mouse_entered():
	$Skill_name.text = ("House")
	$Description.text = ("Get a block on each upgrade and Gain ability to place a block underdeath your character")


func _on_block_addition_mouse_exited():
	$Skill_name.text = ("")
	$Description.text = ("")



func _on_blue_flame_btn_mouse_entered():
	$Skill_name.text = ("Phoenix")
	$Description.text = ("Phoenix fires a fire ball that spreads the fire to the ground. (you can only use again after the fire disappears.)")



func _on_blue_flame_btn_mouse_exited():
	$Skill_name.text = ("")
	$Description.text = ("")

func _on_shield_btn_mouse_entered():
	$Skill_name.text = ("Tech")
	$Description.text = ("Gain an ability to use radioactive shield ")

func _on_shield_btn_mouse_exited():
	$Skill_name.text = ("")
	$Description.text = ("")
	
func _on_block_addition_pressed():
	if player.coins - 5 >= 0:
		player.coins -= 5
		main.available_blocks += 1


func _on_enhanced_attack_btn_pressed():
	if player.coins - 20 >= 0 and player.upgrade_enhanced_numbers > 1:
		player.coins -= 20
		player.upgrade_enhanced_numbers -= 1
	else:
		print("maxed out!!")

func _on_attack_speed_btn_pressed():
	if player.coins - 10 >= 0 and player.upgrade_numbers == 3:
		player.coins -= 10
		player.get_node("Attack_Timer").wait_time = player.get_node("Attack_Timer").wait_time-0.02
		player.upgrade_numbers -= 1
	elif player.coins - 30 >= 0 and player.upgrade_numbers == 2:
		player.coins -= 30
		player.get_node("Attack_Timer").wait_time = player.get_node("Attack_Timer").wait_time-0.03
		player.upgrade_numbers -= 1
	elif player.coins -50 >= 0 and player.upgrade_numbers == 1:
		player.coins -= 50
		player.get_node("Attack_Timer").wait_time = player.get_node("Attack_Timer").wait_time-0.04
		player.upgrade_numbers -= 1
	else:
		print("maxed_out!!")

func _on_blue_flame_btn_pressed():
	if player.coins - 30 >= 0:
		player.coins -= 30
		main.phoenix_skill_num += 1

func _on_shield_btn_pressed():
	if player.coins - 15 >= 0 and shield_activation == false:
		shield_activation = true 
		
