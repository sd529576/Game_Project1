extends CharacterBody2D

var target_position
var monster = Node2D
var monster_position
var speed = 400
var blue_flame = preload("res://blue_fire/Blue_flame.tscn").instantiate()
var once = false
@onready var mon_container = get_parent().get_parent().get_node("Monster_container")

signal blue_flame_up
func _physics_process(_delta):
	velocity.y = 200
	velocity.x = 30
	$AnimatedSprite2D.play("new_animation")
	
	if is_on_floor():
		if once == false:
			blue_flame_up.emit()
			blue_flame.position.x = position.x
			blue_flame.position.y = position.y + 10
			get_parent().get_parent().get_node("Testing_container").add_child(blue_flame)
			once = true
			queue_free()
	move_and_slide()
	"""
	player_position = player.position
	target_position = (player_position - position).normalized()
	velocity.x = target_position.x*speed
	move_and_slide()
"""
