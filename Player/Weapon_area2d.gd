extends Area2D

signal attacked
var attack_value = 0
var attackable_list = ["King_slime","Monster2","baby_slime","Gladiator","baby_slime","tree_obstacle"]
@onready var boss_slime = preload("res://boss_slime/king_slime_boss.tscn").instantiate()
func _on_body_entered(body):
	for i in attackable_list:
		if body.is_in_group(i):
			if get_parent().get_parent().get_node("AnimationPlayer").current_animation == "Attack":
				attack_value = 20
				body.get_node("Area2D").damage_dealt = 20
				body.get_node("Area2D").knock_back.emit()
				body.health -= attack_value
			elif get_parent().get_parent().get_node("AnimationPlayer").current_animation == "charge_attack":
				attack_value = 30
				body.get_node("Area2D").damage_dealt = 30
				body.get_node("Area2D").knock_back.emit()
				body.health -= attack_value
			attacked.emit()
		else:
			pass
		
