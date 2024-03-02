extends Area2D

signal attacked

func _on_body_entered(body):
	if body.is_in_group("Monster2") or body.is_in_group("King_slime") or body.is_in_group("baby_slime") or body.is_in_group("Gladiator") or body.is_in_group("baby_slime"):
		if get_parent().get_parent().get_node("AnimationPlayer").current_animation == "Attack":
			body.get_node("Area2D").damage_dealt = 20
			body.get_node("Area2D").knock_back.emit()
			body.health -= 20
		elif get_parent().get_parent().get_node("AnimationPlayer").current_animation == "charge_attack" or body.is_in_group("Gladiator") or body.is_in_group("baby_slime"):
			body.get_node("Area2D").damage_dealt = 30
			body.get_node("Area2D").knock_back.emit()
			body.health -= 30
		attacked.emit()
