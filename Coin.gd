extends Area2D

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.has_method("getcoin"):
		body.getcoin()
		queue_free()
