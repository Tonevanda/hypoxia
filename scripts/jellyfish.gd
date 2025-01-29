extends Node2D

var collidingEntities = []
const SPEED = 10.0


func handleCollisions():
	for entity in collidingEntities:
		if entity.name.begins_with("Projectile"):
			get_parent().num_enemies -= 1
			get_parent().generateJellyBubble(position)
			if get_parent().num_enemies == 0:
				get_parent().generateEndRoom()
			queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleCollisions()
	
