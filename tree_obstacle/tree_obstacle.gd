extends CharacterBody2D

var health = 100
func _process(_delta):
	$AnimatedSprite2D2.play("default")
