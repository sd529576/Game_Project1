extends CharacterBody2D

var health = 100
var speed = 40
var jump_velocity = 5000
var player_position
var target_position
var player_chase = false
var charged = false
var distance_traveled = 5
var stopped = false
var walking_distance = 2
var gravity = 5
@onready var player = get_parent().get_parent().get_node("Player")


func _physics_process(_delta):
	position.y += gravity
	if is_on_floor() and player_chase:
		gravity = 0
		#monster facing directions based on the player position
		#Monster is coming from left
		#hmm represents t
		if player.position > position and distance_traveled >=0 and stopped == true:
			distance_traveled -= 1
			position.x += (player.position.x - position.x)/speed +15
		elif player.position < position and distance_traveled >= 0 and stopped == true:
			distance_traveled -= 1
			position.x += (player.position.x - position.x)/speed -15
			if player.position > position:
				charged = true
		"
		print(player.position)
		print(position)
		print((player.position - position)/speed)
		"
	move_and_slide()
#area_to_chase
func _on_area_2d_body_entered(body):
	if body == player:
		player_chase = true
		$Timer.start()
		if (player.position.x-position.x)>0:
			$AnimatedSprite2D.play("Walk_right")
		elif (player.position.x-position.x)<0:
			$AnimatedSprite2D.play("Walk_left")
func _on_area_2d_body_exited(body):
	if body == player:
		player_chase = false

func _on_timer_timeout():
	stopped = true

