extends Area2D


func _on_body_entered(body):
	print("hmm")
	if body.is_in_group("Climber"):
		print("hmm")
		if body.on_ladder == false:
			body.on_ladder = true
			


func _on_body_exited(body):
	if body.is_in_group("Climber"):
		if body.on_ladder == true:
			body.on_ladder = false
	pass
