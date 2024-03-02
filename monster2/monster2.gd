extends CharacterBody2D

var health = 100
var speed = 150
var jump_velocity = 5000
var player_position
var target_position
var gravity = 3000
var random = RandomNumberGenerator.new()
@onready var area = get_node("Area2D")
@onready var player = get_parent().get_parent().get_node("Player")
var explosion = preload("res://explosion/explosion.tscn").instantiate()
func _ready():
	$Monster2_jump_timer.wait_time = random.randi_range(3,7)
	area.knock_back.connect(knock_backing)
func _physics_process(_delta):
	if health <=0:
		explosion.position = position
		get_parent().get_parent().add_child(explosion)
		explosion.emitting = true
	if not is_on_floor():
		velocity.y += 5
	
	if is_on_floor():
		player_position = player.position
		player_position = player.position
		target_position = (player_position - position).normalized()
		velocity.x = target_position.x*speed
	move_and_slide()
	"""
	if position.y > 700:
		player_position = player.position
		target_position = (player_position - position).normalized()
		velocity = target_position*speed
		move_and_slide()
		
		await get_tree().create_timer(3).timeout
		velocity.y -= 200
		velocity.x = target_position.x*speed
		"""
		
func knock_backing():
	if player.position.x > position.x:
		position.x -= 40
	elif player.position.x < position.x:
		position.x += 40
	position.y -= 10
func _on_monster_2_jump_timer_timeout():
	if is_on_floor():
		velocity.y -= 200
		velocity.x -= 100
