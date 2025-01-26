extends Node2D

@onready var player = get_node("/root/Game/Player/Whale")
@onready var parent = get_parent()
@onready var animation_sprite = get_parent().get_node("AnimatedSprite2D")


func flipH():
	if parent.position.x < player.position.x:
		animation_sprite.flip_h = true
	elif parent.position.x > player.position.x:
		animation_sprite.flip_h = false
		

func move(delta: float):
	parent.position.x = move_toward(parent.position.x, player.position.x, parent.SPEED*delta)
	parent.position.y = move_toward(parent.position.y, player.position.y, parent.SPEED*delta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
	flipH()
