extends Area2D

func _on_area_entered(area):
	if area in get_node("../../bulletContainer").get_children():
		print(area)
		area.queue_free()
		


func _on_body_entered(body):
	print(body)
	if body.is_in_group("Coin_ball"):
		body.queue_free()
		get_parent().position.x -= 300
	if body.is_in_group("Wood_box"):
		body.queue_free()
		get_parent().num_box += 1
		
