extends Node2D

@onready var player_attack_rcv = get_parent().get_node("Player/Player_body/Weapon_area2d")

func _ready():
	player_attack_rcv.attacked.connect(play_sound)


func play_sound():
	get_node("slime_attacked").play()
	print("working?")
