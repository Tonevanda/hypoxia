extends Node2D



@onready var player = get_node("/root/Game/Player/Whale")
var collidingEntities = []
const SPEED = 10.0

func handleCollisions(delta: float):
	for entity in collidingEntities:
		if entity.name.begins_with("Projectile"):
			get_parent().num_enemies -= 1
			if get_parent().num_enemies == 0:
				get_parent().generateEndRoom()
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !collidingEntities.is_empty():
		handleCollisions(delta)
	else:
		position.x = move_toward(position.x, player.position.x, SPEED*delta)
		position.y = move_toward(position.y, player.position.y, SPEED*delta)
	collidingEntities = []
