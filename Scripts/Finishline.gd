extends Area2D

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	set_process(false)
	if body.is_in_group("Player1"):
		body.set_physics_process(false)
		body.hud.visible = false
		body.end_hud.visible = true
		body.end_coin.text = ("Coins Collected: " + str(body.coin) + " / " + str(40))
		if body.coin == 40:
			body.congrats.visible = true

func finish_game(body):
	body.GUI.Visible = false
