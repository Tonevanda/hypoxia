extends Node2D

@onready var player = get_node("/root/Game/Player/Whale")
@onready var parent = get_parent()

var SPEED = 10.0


func move(delta: float):
	parent.position.x = move_toward(parent.position.x, player.position.x, SPEED*delta)
	parent.position.y = move_toward(parent.position.y, player.position.y, SPEED*delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
