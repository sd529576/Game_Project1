
var red = Color(1.0,0.0,0.0,1.0)

func _ready():
	Player_var.Fever_damage.connect()


func red1():
	get_node("Label").modulate(red)
