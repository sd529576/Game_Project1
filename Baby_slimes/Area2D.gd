extends Area2D


var tick = 3
var flame_detected = false
var damage_dealt = 0
signal knock_back
#signal attack_detection
func _on_area_entered(area):
	if area in get_node("../../../bulletContainer").get_children():
		damage_dealt = 20
		area.queue_free()
		get_parent().health = get_parent().health - 20
		knock_back.emit()
	for i in get_parent().get_parent().get_parent().get_node("Testing_container").get_children():
		if i.name == "Blue_flame":
			tick = 3
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
		tick -= 1
	elif tick <= 0:
		get_parent().get_node("flamed").hide()
