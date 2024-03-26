extends Area2D

func _on_area_entered(area):
	print(area)
	if area in get_node("../../bulletContainer").get_children():
		area.queue_free()
		
