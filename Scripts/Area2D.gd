extends Area2D

onready var timer = $Timer
var body_detch = false

func _on_Area2D_body_entered(body):
	body_detch = true
	if body.is_in_group("Player1") and body_detch == true:
		body.attack_detech(25)

func _on_Area2D_body_exited(_body):
	body_detch = false
