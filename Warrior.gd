extends KinematicBody2D


const UP = Vector2(0, -1)
const Gravity = 20
const Speed = 200
const Jump_height = -500

var motion = Vector2()
var state

onready var ANIplayer = $AnimationPlayer
onready var sprite := $Position2D/Sprite
onready var flip := $Position2D




# Called when the node enters the scene tree for the first time.
func _physics_process(delta:float) -> void:
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
		body.attacked()

func attack_detech():
	print('player deteched')
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



