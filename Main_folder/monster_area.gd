extends Area2D

#var bullet_list_ = []
func _on_area_entered(area):
	#print(get_node("../../Player").bullet_list)
	#alternate way to detect child nodes
	#bullet_list_ = get_node("../../Player").bullet_list
	if area in get_node("../../bulletContainer").get_children():
		area.queue_free()
	
	
	
	
	# this shows the list of children object from the bullet container, originally I had to createa a list to manually add the children nodes to the separate list, but figured out how to view children nodes
	
	#print(get_node("../../bulletContainer").get_children())
	

