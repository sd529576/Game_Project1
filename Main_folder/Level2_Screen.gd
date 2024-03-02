extends Camera2D



func _on_timer_timeout():
	#get_node("Level2_boss/CharacterBody2D").move_speed = 10
	position.x = position.x + 5
