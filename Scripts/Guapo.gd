extends Node2D

onready var timer = $Timer
onready var flashbang = $White
onready var Insta = $Area2D
onready var sound = $AudioStreamPlayer

var counter = 0
var entered = 0

func _on_Cheese_body_entered(body):
	if body.is_in_group("Player1"):
		print("Has fallen into a trap!")
		timer.wait_time = 1.25
		timer.start()
		entered += 1
		body.attack_detech(99999)
			
			
				

func _on_Timer_timeout():
	if entered == 1:
		
		flashbang.visible = true
		Insta.monitoring = true
		if counter == 0 :
			counter += 1
			sound.play()
