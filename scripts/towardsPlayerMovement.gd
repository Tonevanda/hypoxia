extends Node2D

<<<<<<<< HEAD:scripts/towardsPlayerMovement.gd
========

@onready var player = get_node("/root/Game/Player")
>>>>>>>> 2835cdaa6b9ead1be9912383ad3fac6197260b51:scripts/pufferfish.gd
var isColliding = false
const SPEED = 10.0
@onready var player = get_node("/root/Game/Whale")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isColliding:
		position.x = move_toward(position.x, player.position.x, SPEED*delta)
		position.y = move_toward(position.y, player.position.y, SPEED*delta)
<<<<<<<< HEAD:scripts/towardsPlayerMovement.gd
========

func _on_body_entered(body: Node2D) -> void:
	isColliding = true


func _on_body_exited(body: Node2D) -> void:
	isColliding = false
>>>>>>>> 2835cdaa6b9ead1be9912383ad3fac6197260b51:scripts/pufferfish.gd
