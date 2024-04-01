extends Area2D

func _on_body_entered(body):
#	print(body)
	for i in get_parent().get_parent().get_node("Coin_ball_container").get_children():
#		print(i)
		if body == i:
			i.picked = true
