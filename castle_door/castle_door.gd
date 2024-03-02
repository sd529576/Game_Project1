extends CharacterBody2D

@onready var monster_container = get_parent().get_node("Monster_container")
func _physics_process(_delta):
	if get_parent().get_node("Main_Timer_container/Round_timer").paused == true:
		position.x = -660
		show()
		velocity.y += 30
		move_and_slide()


