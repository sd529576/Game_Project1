extends Node2D

@onready var main_world = preload("res://Main_folder/main.tscn")
var merchant_screen = preload("res://Merchant/Merchant_screen.tscn")
var Option_screen = preload("res://Option_menu/Option_Menu.tscn")

func _process(_delta):
	if $Option_Menu.visible == false:
		$Label_container_with_btns.show()
		#$Lobby_background_music.play()
		
func running_scene(scene):
	$ColorRect.hide()
	var instance = scene.instantiate()
	add_child(instance)

func _on_timer_timeout():
	$RichTextLabel2.modulate.a = $RichTextLabel2.modulate.a -0.1


func _on_play_button_pressed():
	running_scene(main_world)


func _on_merchant_button_pressed():
	$RichTextLabel2.modulate.a = 1.0
	$RichTextLabel2.show()
	$Timer.start()


func _on_exit_button_pressed():
	get_tree().quit()


func _on_option_button_pressed():
	$Label_container_with_btns.hide() #hiding all the texts and btns when option btn is clicked.
	#$Lobby_background_music.hide() # the background music slider should also disappear
	$Option_Menu.show()
