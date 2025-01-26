extends Node2D


var num_enemies = 10


func generateEndRoom():
	var spawner = get_child(2)
	spawner.spawnBubble()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
