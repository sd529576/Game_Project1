extends Area2D

func _on_body_entered(body):
	print(body)
	if body.is_in_group("Coin_ball"):
		get_parent().get_parent().get_node("Coin_ball_container/RigidBody2D").picked = true
