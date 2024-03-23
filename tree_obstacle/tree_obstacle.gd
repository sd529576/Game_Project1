extends CharacterBody2D

var health = 100
var tree_sound_rotation = 1
@onready var area = get_node("Area2D")

func _ready():
	area.knock_back.connect(tree_shakes)
func tree_shakes():
	if health <= 0:
		queue_free()
	$AnimatedSprite2D2.play("default")
	health = health - 20
	if tree_sound_rotation == 1:
		tree_sound_rotation = 2
		$tree_shake_sound1.play()
	elif tree_sound_rotation == 2:
		tree_sound_rotation = 3
		$tree_shake_sound2.play()
	elif tree_sound_rotation == 3:
		tree_sound_rotation = 1
		$tree_shake_sound3.play()
	print("shaking?")
