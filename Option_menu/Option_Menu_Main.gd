extends Node2D
#Camera2D2.make_current()

func _on_back_btn_pressed():
	hide()
	$Camera2D.make_current()
