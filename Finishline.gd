extends Area2D

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	set_process(false)
	if body.is_in_group("Player1"):
		body.set_physics_process(false)

func finish_game(body):
	body.GUI.Visible = false
