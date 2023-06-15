extends Node2D

onready var timer = $Timer
onready var flashbang = $"Licensed-image"
onready var Insta = $Area2D
onready var sound = $AudioStreamPlayer

var counter = 0

func _on_Cheese_body_entered(body):
	if body.is_in_group("Player1"):
		timer.wait_time = 0.5
		timer.start()
		
		if body.has_method("attack_detech"):
			body.attack_detech(99999)
			

func _on_Timer_timeout():
	flashbang.visible = true
	Insta.monitoring = true
	if counter == 0:
		
		counter += 1
		sound.play()
	

