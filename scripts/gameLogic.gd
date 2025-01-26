extends Node2D


var num_enemies = 10
var current_level = 1
const map_width = 320
const map_height = 160
const map_x = -160
const map_y = -80
@onready var spawner = get_node("Spawner")


func generateEndRoom():
	spawner.spawnBubble()
	
func generateNewLevel():
	current_level += 1
	spawner.difficulty = randi_range(current_level*3, current_level*6)
	spawner.spawn_mobs()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
