extends Area2D
var damage = preload("res://Damage_notif/damage_notf.tscn").instantiate()
var flame_detected = false
var damage_dealt = 0
signal knock_back
func _on_area_entered(area):
	#print(get_node("../../Player").bullet_list)
	#alternate way to detect child nodes
	#bullet_list_ = get_node("../../Player").bullet_list
	if area in get_node("../../../bulletContainer").get_children():
		damage_dealt = 20
		area.queue_free()
		get_parent().health -= 20
		knock_back.emit()
		get_parent().get_parent().get_parent().get_node("Monster_sound_container/slime_attacked").play()
	for i in get_parent().get_parent().get_parent().get_node("Testing_container").get_children():
		if i.name == "Blue_flame":
			if area == get_parent().get_parent().get_parent().get_node("Testing_container/Blue_flame/Area2D"):
				flame_detected = true
				get_parent().get_node("flamed").show()
				get_parent().get_node("flamed").play("default")
		else:
			get_parent().get_node("flamed").hide()
	damage_dealt = 0
func _on_tick_timer_timeout():
	if flame_detected == true:
		damage_dealt = 10
		knock_back.emit()
		get_parent().health -= 10
		get_parent().get_parent().get_parent().get_node("Monster_sound_container/slime_attacked").play()
