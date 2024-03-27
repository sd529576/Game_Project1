extends CharacterBody2D

func _process(_delta):
	$AnimationPlayer.play("default")
	
	
var move_speed = 3.5

func _physics_process(_delta):
	position.x += move_speed
	
	move_and_slide()
