extends CharacterBody2D
var health = 100
var speed = 100
var jump_velocity = 5000
var player1_position
var target_position
var gravity = 3000
var random = RandomNumberGenerator.new()
@onready var player1 = get_parent().get_parent().get_node("Player")
@onready var area = get_node("Area2D")
var explosion = preload("res://explosion/explosion.tscn").instantiate()
func _ready():
	area.knock_back.connect(knock_backing)
func _physics_process(_delta):
	"""
	if health <=0:
		explosion.position = position
		get_parent().get_parent().add_child(explosion)
		explosion.emitting = true
		"""
	if not is_on_floor():
		velocity.y += 5
	
	if is_on_floor():
		player1_position = player1.position
		player1_position = player1.position
		target_position = (player1_position - position).normalized()
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
	if player1.position.x > position.x:
		position.x -= 30
	elif player1.position.x < position.x:
		position.x += 30
	position.y -= 10
