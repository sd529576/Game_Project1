extends CharacterBody2D

var health = 1000
var gravity = 3000
var rng = RandomNumberGenerator.new()
var direction = 1
var time_out = false
@onready var player = get_parent().get_parent().get_node("Player")
@onready var healthbar = $ProgressBar
signal boss_function_called 
var explosion = preload("res://explosion/explosion.tscn").instantiate()

func _ready():
	healthbar.init_health(health)

func _physics_process(delta):
	if health <=0:
		explosion.position = position
		get_parent().get_parent().add_child(explosion)
		explosion.emitting = true
		
	velocity.y += gravity*delta
	
	if is_on_floor():
		velocity.x = 0
	
	move_and_slide()
	healthbar.health = health
	healthbar._set_health(health)
func _on_jump_timer_timeout():
	var left_to_right_num = rng.randf_range(700,300)
	var right_to_left_num = rng.randf_range(-300,-700)
	
	var random_number = 0
	if position.x <= -1077:
		random_number = left_to_right_num
	elif position.x >= -76.09:
		random_number = right_to_left_num
	else:
		random_number = rng.randf_range(-500,500)
	velocity.y -= 1500
	velocity.x += random_number
	$KingSlimeIdle1.hide()
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play("default")
	
	move_and_slide()
	
	spread()
	
func spread():
	if health < 200 and get_parent().get_parent().paused == false:
		boss_function_called.emit()

	
	
