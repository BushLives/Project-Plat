extends Area2D

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.has_method("getcoin"):
		body.base_damage += 0.5
		body.Speed += 0.25
		body.getcoin()
		queue_free()
		print(str(body.base_damage) + ":" + str(body.Speed) + ":" + str(body.health))
