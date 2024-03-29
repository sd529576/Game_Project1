extends CharacterBody2D

func _process(_delta):
	$AnimationPlayer.play("default")
	
	
var move_speed = 3.5

func _physics_process(_delta):
	#await get_tree().create_timer(5).timeout
	if get_parent().Level_dict["Level2"] == true:
		position.x += move_speed
	
	move_and_slide()
