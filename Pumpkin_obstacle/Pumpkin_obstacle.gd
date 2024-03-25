extends CharacterBody2D

var gravity = 3000
var speed = 100


func _process(_delta):
	$AnimatedSprite2D.play("default")
func _physics_process(_delta):
	print(velocity.x,velocity.y)
	#if not is_on_floor():
	if Input.is_action_just_pressed("run it"):
		print("runitworking?")
		velocity.y += 50
		velocity.x -= 200
	
	move_and_slide()
