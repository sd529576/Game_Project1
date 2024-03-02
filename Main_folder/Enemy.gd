extends Area2D
@export var move_speed : float = 300
@export var starting_direction : Vector2 = Vector2(0,1)

var jump_velocity = -500.0
var state = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	position.x = 0
	position.y = 0
