extends Control

func _on_Restart_Button_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")

func _on_Quit_Button_pressed():
	get_tree().quit()
