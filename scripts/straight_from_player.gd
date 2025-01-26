extends Node2D

@onready var player = get_node("/root/Game/Player/Whale")
@onready var parent = get_parent()
@onready var animation_sprite = get_parent().get_node("AnimatedSprite2D")
@onready var player_animation_sprite = get_node("/root/Game/Player/Whale/AnimatedSprite2D")
var direction = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !player_animation_sprite.flip_h:
		direction = -1
		animation_sprite.flip_h = true
	parent.position = player.position


func move(delta: float):
	parent.position.x += direction * parent.SPEED * delta
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move(delta)
