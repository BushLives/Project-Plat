extends Control

func _on_Play_pressed():
	get_tree().change_scene("res://Level1.tscn")

func _on_Controls_pressed():
	get_tree().change_scene("res://Control.tscn")
	
func _on_Credits_pressed():
	get_tree().change_scene("res://Credits.tscn")
