extends Node2D

var isColliding = false
const SPEED = 10.0
@onready var player = get_node("/root/Game/Whale")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isColliding:
		position.x = move_toward(position.x, player.position.x, SPEED*delta)
		position.y = move_toward(position.y, player.position.y, SPEED*delta)
