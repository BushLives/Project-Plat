extends Control

func _on_Play_Again_pressed():
	get_tree().change_scene("res://Level1.tscn")


func _on_MainMenu_pressed():
	get_tree().change_scene("res://Main_Menu.tscn")
