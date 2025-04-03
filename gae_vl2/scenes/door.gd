extends Area2D

signal door_reached

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		door_reached.emit()
