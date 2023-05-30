extends KinematicBody2D

const UP = Vector2(0, -1)
const Gravity = 20
const Speed = 350
const Jump_height = -750

var motion = Vector2()
var health = 250
var coin = 0
var state

onready var ANIplayer = $AnimationPlayer
onready var sprite := $Position2D/Sprite
onready var flip := $Position2D
onready var healthbar:= $TextureProgress
onready var timer := $Timer


# Called when the node enters the scene tree for the first time.
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
		
	motion = move_and_slide(motion, UP)
	
func player_attack():
	state.travel("Att_1")
	
func _on_Player_attack_body_entered(body):
	if body.has_method('attacked'):
		body.attacked(10)
		frameFreeze(0.05,1.0)

func attack_detech(damage):
	
	if health <= 0:
		print("dead")
		state.travel("Dead")
	elif health > 0:
		healthbar.visible = true
		health -= damage
		healthbar.value = health
		timer.wait_time = 1
		timer.start()
		print(health)
		
func frameFreeze(timescale, duration):
	Engine.time_scale = timescale
	yield(get_tree().create_timer(duration * timescale), "timeout")
	Engine.time_scale = 1.0

func _on_Timer_timeout():
	healthbar.visible = false

func getcoin():
	coin += 1
	print(coin)
