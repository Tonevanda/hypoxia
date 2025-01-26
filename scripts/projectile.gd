extends Node2D

var collidingEntities = []
@export var SPEED = 100.0


func handleCollisions():
	collidingEntities = []
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !collidingEntities.is_empty():
		handleCollisions()

	
