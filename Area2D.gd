extends Area2D

var a = Node2D.new()
var flame_detected = false
var tick = 3
var damage_dealt
signal knock_back

func _process(_delta):
	print(flame_detected)
func _on_area_entered(area):
	a = get_parent().get_parent().get_parent().get_node("Baby_slime_container")
	if area in get_node("../../../bulletContainer").get_children() and len(a.get_children()) == 0:
		damage_dealt = 20
		area.queue_free()
		get_parent().health = get_parent().health - 20
		print(get_parent().health)
		knock_back.emit()
	for i in get_parent().get_parent().get_parent().get_node("Testing_container").get_children():
		if i.name == "Blue_flame":
			tick = 5
			if area == get_parent().get_parent().get_parent().get_node("Testing_container/Blue_flame/Area2D") and len(a.get_children()) == 0:
				flame_detected = true
				get_parent().get_node("flamed").show()
				get_parent().get_node("flamed").play("default")
	damage_dealt = 0


func _on_tick_timer_timeout():
	if flame_detected == true and tick > 0:
		damage_dealt = 10
		knock_back.emit()
		get_parent().health -= 10
		tick -= 1
	elif tick <= 0:
		get_parent().get_node("flamed").hide()
