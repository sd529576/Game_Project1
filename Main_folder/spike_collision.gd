extends Area2D



func _on_area_entered(area):
	if area.name == "Attacked_collision":
		get_parent().get_node("Player/Attacked_collision").hurt = true
