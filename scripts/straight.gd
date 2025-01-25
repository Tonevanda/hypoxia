extends Node2D

var isColliding = false
const SPEED = 10.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isColliding:
		queue_free()
	else:
		position.x += SPEED * delta
