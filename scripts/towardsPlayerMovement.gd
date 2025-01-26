extends Node2D



@onready var player = get_node("/root/Game/Player/Whale")
@onready var animated_sprite = $AnimatedSprite2D
var collidingEntities = []
const SPEED = 10.0
var animation_state = "walk"
var attack_time = 0.0

func handleCollisions():
	for entity in collidingEntities:
		print(entity.name)
		if entity.name.begins_with("Projectile"):
			get_parent().num_enemies -= 1
			if get_parent().num_enemies == 0:
				get_parent().generateEndRoom()
			queue_free()

func move(delta: float):
	if animation_state != "attack":
		position.x = move_toward(position.x, player.position.x, SPEED*delta)
		position.y = move_toward(position.y, player.position.y, SPEED*delta)

func animate(delta: float):
	animated_sprite.play(animation_state)
	if animation_state == "attack":
		attack_time += delta
		if attack_time >= 0.3:
			animation_state = "walk"
			attack_time = 0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	handleCollisions()
	move(delta)
	animate(delta)
