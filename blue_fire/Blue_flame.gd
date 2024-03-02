extends Area2D
var hmm = randf_range(0,5)

func _process(_delta):
	for i in get_node("Node2D").get_children():
		if int(hmm) % 2 == 0:
			i.play("default")
		else:
			i.play("new_animation")
