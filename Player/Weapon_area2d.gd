extends Area2D

signal attacked
var attackable_list = ["King_slime","Monster2","baby_slime","Gladiator","baby_slime","tree_obstacle"]

func _on_body_entered(body):
	print(body.name)
	for i in attackable_list:
		if body.is_in_group(i):
			if get_parent().get_parent().get_node("AnimationPlayer").current_animation == "Attack":
				body.get_node("Area2D").damage_dealt = 20
				body.get_node("Area2D").knock_back.emit()
				body.health -= 20
			elif get_parent().get_parent().get_node("AnimationPlayer").current_animation == "charge_attack":
				body.get_node("Area2D").damage_dealt = 30
				body.get_node("Area2D").knock_back.emit()
				body.health -= 30
			attacked.emit()
		else:
			pass
