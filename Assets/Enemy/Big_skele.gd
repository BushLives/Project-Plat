extends KinematicBody2D

var velocity = Vector2(450, 0)
var gravity = 20
var turned_side:bool
var health = 650
var shield = 100
var base_damage = 8

onready var state = $AnimationTree.get('parameters/playback')

func _ready():
	$GUI/Health.max_value = health
	$GUI/Shield.value = shield
	$GUI/Health.value = health
	state.travel('Walk')
	
func _physics_process(_delta):
	velocity.y += gravity
	
	move_and_slide(velocity,Vector2.UP)
	if health <= 0:
		state.travel("Dead")
		set_physics_process(false)

func change_state():
	velocity.x *= -1
	scale.x *= -1

	if velocity.x < 0 and health > 0:
		turned_side = true
	elif velocity.x > 0 and health > 0:
		turned_side = false 

	
		
func _on_detech_player_body_entered(body):
	if body.is_in_group('Player1') and health > 0:
		state.travel('Attack')
		velocity = Vector2(0,0)
	elif health <= 0:
		state.travel("Dead")
		set_physics_process(false)
			
func _on_detech_player_body_exited(body):
	if body.is_in_group('Player1'):
		state.travel("Walk")
		if turned_side == true and health > 0:
			velocity.x = -450
		elif turned_side == false and health > 0:
			velocity.x = 450
		else:
			state.travel("Dead")
			set_physics_process(false)
		

func _on_attack_to_player_body_entered(body):
	if body.is_in_group('Player1'):
		body.attack_detech(base_damage)


func _on_player_is_back_body_entered(body):
	if body.is_in_group('Player1'):
		change_state()

func attacked(damage):
	$GUI/Shield.value = shield
	$GUI/Health.value = health
	if shield > 0:
		shield -= damage
	else:
		health -= damage
		$Timer.wait_time = 1
		$Timer.start()
		if health <= 0:
			state.travel("Dead")
			set_physics_process(false)
		elif health <= 100:
			
			print(base_damage)
			
			
func _on_Timer_timeout():
	pass
