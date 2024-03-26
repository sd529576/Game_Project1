extends CharacterBody2D

var move_speed = 4

func _physics_process(_delta):
	position.x += move_speed
	
	move_and_slide()
