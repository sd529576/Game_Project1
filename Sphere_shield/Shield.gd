extends Area2D

func _on_area_entered(area):
	for i in get_parent().get_parent().get_node("Monster_container").get_children():
		if area == i.get_node("Area2D"):
			i.get_node("Area2D").knock_back.emit()
			get_parent().get_parent().get_node("Monster_sound_container/slime_attacked").play()
		
