extends Node2D

@onready var parent = get_parent()
@onready var animation_sprite = get_parent().get_node("AnimatedSprite2D")
@onready var game = get_node("/root/Game")
@onready var target = Vector2(randf_range(game.map_x, game.map_width/2), randf_range(game.map_y, game.map_height/2))


func _ready():
	flipH()
	
func flipH():
	if target.x > parent.position.x:
		animation_sprite.flip_h = false
	elif target.x < parent.position.x:
		animation_sprite.flip_h = true
	
func move(delta: float):
	parent.position.x = move_toward(parent.position.x, target.x, parent.SPEED*delta)
	parent.position.y = move_toward(parent.position.y, target.y, parent.SPEED*delta)
	if target == parent.position:
		target.x = randf_range(game.map_x, game.map_width/2)
		target.y = randf_range(game.map_y, game.map_height/2)
		flipH()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
