extends Area2D
@export var move_speed : float = 300
@onready var normalsprite = get_parent().get_node("SpritesheetFinal")
@onready var monster_container = get_parent().get_parent().get_node("Monster_container")
@onready var slime_container = get_parent().get_parent().get_node("Baby_slime_container")
@onready var reaper = get_parent().get_parent().get_node("Reaper")
@onready var spear_container = get_parent().get_parent().get_node("Spear_container")
var hurt = false
var attack_bounce_direction = 1
func _on_body_entered(body):
	"""
	when the player gets into the collision area of monster, it plays the "attacked" animation
	from AnimatedSprite2D
	"""
	if body in monster_container.get_children() or body in slime_container.get_children() or body in spear_container.get_children() or body in reaper.get_children() and get_parent().death_once == false:
		hurt = true
		"""
		normalsprite.visible = false
		get_parent().get_node("AnimatedSprite2D").visible = true
		"""
		# if the position of x to the mob is left side of the player, play attacked from left
		if body.position.x < get_parent().position.x:
			attack_bounce_direction = 1
			get_parent().get_node("AnimationPlayer").play("attacked")
			print("hello? plz?")
			#get_parent().velocity.x = -5000
			get_parent().velocity.y = get_parent().jump_velocity
		# if the position of x to the mob is right side of the player, play attacked from the right
		elif body.position.x > get_parent().position.x:
			attack_bounce_direction = -1
			get_parent().get_node("AnimationPlayer").play("attacked")
			print("hello? plz?")
			#get_parent().velocity.x = 5000
			get_parent().velocity.y = get_parent().jump_velocity
			
	if body in get_parent().get_parent().get_node("Coin_bag").get_children():
		body.queue_free()
		get_parent().get_parent().get_node("Main_sound_container/Coin_collecting_sound").play()
		get_parent().get_parent().get_node("Player").coins += 5
	#print(get_parent().get_node("AnimatedSprite2D").frame)
	# this can also become like a respawn with multiple life
	if get_parent().get_node("AnimatedSprite2D").frame == 2:
		normalsprite.visible = true
		get_parent().get_node("AnimatedSprite2D").visible = false
	# hurt animation still needs to be added
