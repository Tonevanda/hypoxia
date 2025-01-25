extends Node2D

@onready var pufferfish_scene = preload("res://scenes/pufferfish.tscn")
var id = 1
var difficulty = 0
var difficulties = [1]
var mobs = ["Pufferfish"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	difficulty = randi_range(1, 7)


func spawn_pufferfish() -> void:
	var pufferfish = pufferfish_scene.instantiate()
	pufferfish.rotation = PI
	pufferfish.position = Vector2(randi_range(-100, 100), randi_range(-100, 100))
	pufferfish.name = "Pufferfish" + str(id)
	get_parent().add_child(pufferfish)
	id += 1
	
	
func spawn_mobs():
	while difficulty > 0:
		var index = randi_range(0, 0)
		
		difficulty -= difficulties[index]
		var mob_name = mobs[index]
		if mob_name == "Pufferfish":
			spawn_pufferfish()


func _on_timer_timeout() -> void:
	spawn_mobs()
