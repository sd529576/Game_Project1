extends Area2D

@export var speed = 500
var facing_direction = 1
var delta_pre = 0
func _physics_process(delta):
	global_position.x += facing_direction*speed*delta
	global_position.y += speed*delta
	
	if facing_direction < 0:
		$AnimatedSprite2D2.play("default")
	elif facing_direction > 0:
		$AnimatedSprite2D2.play("right_side_attack")
func _on_screen_exited():
	queue_free()
