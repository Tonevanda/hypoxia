extends Node2D

var collidingEntities = []



func handleCollisions():
	for entity in collidingEntities:
		if entity.name == "Whale":
			entity.get_parent().reset_oxigen()
			if name.begins_with("EndBubble"):
				entity.get_parent().get_parent().generateNewLevel()
			queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleCollisions()
