extends CharacterBody2D


var velocity_x = 0
var velocity_y = 0
var main = preload("res://Main_folder/main.tscn").instantiate()
func _ready():
	$AnimatedSprite2D2.modulate.a = 0.5
	$AnimatedSprite2D2.play("default")
	main.spear_firing.connect(timer_start)
func _physics_process(_delta):
	
	if is_on_floor():
		queue_free()
	move_and_slide()


func timer_start():
	$Timer.start()
func _on_timer_timeout():
	for i in range(10):
		velocity.x += -50
		velocity.y += 100


