extends KinematicBody2D

const UP = Vector2(0, -1)
const Gravity = 20
const Jump_height = -750

var motion = Vector2()
var health = 150
var heal = 150
var Speed = 450.0
var coin = 0
var hit = 0
var shield = 0
var dodge = false
var dodge_counter = 10.0

var base_damage = 8
var state
var counter = 0

onready var ANIplayer = $AnimationPlayer
onready var sprite := $Position2D/Sprite
onready var flip := $Position2D
onready var hud := $GUI
onready var healthbar:= $GUI/Health
onready var healbar:= $GUI/Stam
onready var dodgebar:= $GUI/Dodge
onready var coinGUI := $GUI/Label
onready var shieldbar := $GUI/Shield
onready var timer := $Timer

func _ready():
	healthbar.max_value = health

func _physics_process(_delta:float) -> void:
	motion.y += Gravity
	state = $AnimationTree.get("parameters/playback")
	shieldbar.value = shield
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
		frameFreeze(0.035,1.0)
	elif hit == 1 and health > 0:
		state.travel("Hurt")
		hit = 0
		
	if Input.is_action_just_pressed("ui_select") and counter <= 0 and dodge_counter > 0 or Input.is_action_just_pressed("ui_down") and counter <= 0 and dodge_counter > 0 :
		$Timer.wait_time = 1
		$Timer.start()
		dodge = true
		dodge_counter -= 1
		dodgebar.value -= 1
		sprite.modulate.a8 = 150
		counter += 1
		
		
	motion = move_and_slide(motion, UP)
	
func player_attack():
	state.travel("Att_1")
	
func _on_Player_attack_body_entered(body):
	if body.has_method('attacked'):
		body.attacked(base_damage)
		
func attack_detech(damage):
	if dodge == false:
		healthbar.value = health
		if shield > 0:
			shield -= damage
		else:
			$Timer.wait_time = 1
			$Timer.start()
			hit = 1
			health -= damage
			if hit == 1 and health > 0:
				state.travel("Hurt")
	else:
		pass
		
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
	sprite.modulate.a8 = 255
	dodge = false
	hit = 0
	if hit == 0 and health < healthbar.max_value and heal > 0:
		health += 5
		heal -= 5
		healbar.value -= 5
		healthbar.value += 5
		if health > healthbar.max_value:
			health = 150
	elif counter > 0:
		counter -= 1
		print(counter)
