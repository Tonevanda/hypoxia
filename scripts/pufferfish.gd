extends Area2D


@onready var player = get_node("/root/Game/Whale")
var isColliding = false


const SPEED = 10.0

	#var game_scene = get_node("/root/")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isColliding:
		position.x += 1
	else:
		position.x = move_toward(position.x, player.position.x, SPEED*delta)
		position.y = move_toward(position.y, player.position.y, SPEED*delta)




func _on_body_entered(body: Node2D) -> void:
	isColliding = true


func _on_body_exited(body: Node2D) -> void:
	isColliding = false
