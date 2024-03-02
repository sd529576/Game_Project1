extends Marker2D

@export var damage_node : PackedScene
@onready var area = get_parent().get_node("Area2D")

func popup():
	var damage = damage_node.instantiate()
	damage.position = global_position
	get_tree().current_scene.add_child(damage)
	damage.get_node("Label").text = (str(area.damage_dealt))

func _ready():
	area.knock_back.connect(popup)
