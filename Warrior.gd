extends KinematicBody2D

const UP = Vector2(0, -1)
const Gravity = 20
const Jump_height = -750

var motion = Vector2()
var health = 100
var heal = 150
var Speed = 450.0
var coin = 0
var hit = 0

var base_damage = 8
var state

onready var ANIplayer = $AnimationPlayer
onready var sprite := $Position2D/Sprite
onready var flip := $Position2D
onready var hud := $GUI
onready var healthbar:= $GUI/Health
onready var healbar:= $GUI/Stam
onready var coinGUI := $GUI/Label
onready var timer := $Timer

func _physics_process(_delta:float) -> void:
	motion.y += Gravity
	state = $AnimationTree.get("parameters/playback")
	
	if Input.is_action_pressed("ui_right"):
		state.travel("Movement")
		flip.scale.x = 1
		motion.x = Speed
	elif Input.is_action_pressed("ui_left"):
		state.travel("Movement")
		flip.scale.x = -1
		motion.x = -Speed
	else: 
		motion.x = 0
		state.travel("Idle")
		
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = Jump_height
	else:
		if motion.y == 0:
			state.travel("UptoFall")
		elif motion.y > 0:
			state.travel("Fall")
		else:
			state.travel("Jump")
			
	if Input.is_action_pressed("Attack"):
		player_attack()
	
	if health <= 0:
		print("dead")
		state.travel("Dead")
		hud.visible = false
		set_physics_process(false)
		# frameFreeze(0.05,1.0)
		
	motion = move_and_slide(motion, UP)
	
func player_attack():
	state.travel("Att_1")
	
func _on_Player_attack_body_entered(body):
	if body.has_method('attacked'):
		body.attacked(base_damage)
		
func attack_detech(damage):
	$Timer.wait_time = 1
	$Timer.start()
	hit = 1
	healthbar.value -= damage
	health -= damage
	state.travel("Hurt")
		
func frameFreeze(timescale, duration):
	Engine.time_scale = timescale
	yield(get_tree().create_timer(duration * timescale), "timeout")
	Engine.time_scale = 1.0

func getcoin():
	coin += 1
	coinGUI.text =("X" + str(coin))

func GAME_OVER():
	get_tree().change_scene("res://Game_over.tscn")

func _on_Timer_timeout():
	hit = 0
	if hit == 0 and health < healthbar.max_value and heal > 0:
		health += 1
		heal -= 1
		healbar.value -= 1
		healthbar.value = health
