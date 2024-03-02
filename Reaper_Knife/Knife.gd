extends AnimatedSprite2D

var jumped = false
@onready var player = get_parent().get_parent().get_parent().get_node("Player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if frame in range(9,20) and player.jump_count > 0:
		player.health = player.health
		jumped = true
	elif frame in range(9,20) and player.jump_count <1:
		player.health = 0
