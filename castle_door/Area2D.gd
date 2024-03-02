extends Area2D
var door_opened = false

func _on_area_entered(area):
	if area == get_parent().get_parent().get_node("Player/Attacked_collision"):
		print("yo?")
		get_parent().get_node("AnimatedSprite2D").play("default")
		door_opened = true
			

func _on_area_exited(area):
	if area == get_parent().get_parent().get_node("Player/Attacked_collision"):
		door_opened = false
		get_parent().get_node("AnimatedSprite2D").frame = 0

func _physics_process(_delta):
	if Input.is_action_just_pressed("Up") and door_opened == true:
		get_parent().get_parent().Level_dict["Level2"] = true
