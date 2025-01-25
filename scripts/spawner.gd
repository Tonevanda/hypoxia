extends Node2D

@onready var pufferfish_scene = preload("res://scenes/pufferfish.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func spawn_pufferfish() -> void:
	var pufferfish = pufferfish_scene.instantiate()
	pufferfish.rotation = PI
	pufferfish.position = Vector2(2, 15)
	get_parent().add_child(pufferfish)
	

func _on_timer_timeout() -> void:
	spawn_pufferfish()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
