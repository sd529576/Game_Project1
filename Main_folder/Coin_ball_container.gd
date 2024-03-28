extends Node2D

var coin_ball_src = preload("res://Coin_ball_obs/Coin_ball.tscn")
var coord_update = 0

func _process(delta):
	coord_update = get_parent().get_node("Level2_Screen/Check_me_out").global_position.x
	print(coord_update)
func coin_ball_make():
	var c = coin_ball_src.instantiate()
	c.position.x = coord_update
	c.position.y = 0
	add_child(c)


func _on_timer_timeout():
	coin_ball_make()
