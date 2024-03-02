extends CharacterBody2D

var move_speed = 0

func _physics_process(_delta):
	velocity.x = move_speed
	
	move_and_slide()

