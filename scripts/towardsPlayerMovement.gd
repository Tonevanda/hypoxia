extends Node2D



@onready var player = get_node("/root/Game/Player/Whale")
var collidingEntities = []
const SPEED = 10.0

func handleCollisions(delta: float):
	print(collidingEntities)
	for entity in collidingEntities:
		if entity.name.begins_with("Projectile"):
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !collidingEntities.is_empty():
		print("colliding")
		handleCollisions(delta)
	else:
		position.x = move_toward(position.x, player.position.x, SPEED*delta)
		position.y = move_toward(position.y, player.position.y, SPEED*delta)
	collidingEntities = []
