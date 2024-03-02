extends Area2D

signal knock_back
var damage_dealt = 0

func _on_area_entered(area):
	if area in get_node("../../../bulletContainer").get_children():
		area.queue_free()
		get_parent().health = get_parent().health - 20
	else:
		pass
