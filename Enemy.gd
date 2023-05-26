extends KinematicBody2D

var velocity = Vector2(150, 0)
var gravity = 20
var turned_side:bool
var health = 50

onready var state = $AnimationTree.get('parameters/playback')

func _ready():
	state.travel('Walk')
	
func _physics_process(_delta):
	velocity.y += gravity
	
	move_and_slide(velocity,Vector2.UP)

func change_state():
	velocity.x *= -1
	scale.x *= -1

	if velocity.x < 0:
		turned_side = true
	elif velocity.x > 0:
		turned_side = false 
	
		
func _on_detech_player_body_entered(body):
	if body.is_in_group('Player1'):
		state.travel('Attack')
		velocity = Vector2(0,0)
			
func _on_detech_player_body_exited(body):
	if body.is_in_group('Player1'):
		state.travel('Walk')
		if turned_side == true:
			velocity.x = -150
		elif turned_side == false:
			velocity.x = 150
		

func _on_attack_to_player_body_entered(body):
	if body.is_in_group('Player1'):
		body.attack_detech(10)


func _on_player_is_back_body_entered(body):
	if body.is_in_group('Player1'):
		change_state()

func attacked(damage):
	$TextureProgress.visible = true
	health -= damage
	$TextureProgress.value = health
	$Timer.wait_time = 1
	$Timer.start()
	if health <= 0:
		state.travel("Dead")
		set_physics_process(false)
		$TextureProgress.visible = false
		
func _on_Timer_timeout():
	$TextureProgress.visible = false
