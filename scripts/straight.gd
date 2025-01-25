extends Node2D

var collidingEntities = []
var direction = 1
const SPEED = 10.0


func set_direction(casterDirection: int) -> void:
	direction = casterDirection

func handleCollisions():
	collidingEntities = []
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !collidingEntities.is_empty():
		handleCollisions()
	else:
		position.x += direction * SPEED * delta
	
