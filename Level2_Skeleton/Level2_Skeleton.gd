extends CharacterBody2D


func _process(delta):
	if $AnimationPlayer.is_playing() == false:
		$SkeletonIdle.scale.x = -1
		$AnimationPlayer.play("Idle")
