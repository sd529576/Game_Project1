extends CharacterBody2D

var gravity = 3000
var speed = 100


func _process(_delta):
	$AnimatedSprite2D.play("default")
func _physics_process(_delta):
	if not is_on_floor():
		velocity.y += 5
	velocity.x -= 5
	
	move_and_slide()
