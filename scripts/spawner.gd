extends Node2D

@onready var pufferfish_scene = preload("res://scenes/pufferfish.tscn")
@onready var jellyfish_scene = preload("res://scenes/jellyfish.tscn")
@onready var bubble_scene = preload("res://scenes/bubble.tscn")
@onready var game = get_parent()
var id = 1
var difficulty = 0
var difficulties = [1, 3]
var mobs = ["Jellyfish", "Pufferfish"]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	difficulty = randi_range(1, 7)

#-160, -80 top left
#-160, 80 bot left
func spawn_pufferfish() -> void:
	var pufferfish = pufferfish_scene.instantiate()
	#pufferfish.position = Vector2(randi_range(game.map_x, game.map_width), randi_range(-game.map_y, game.map_height))
	pufferfish.position = Vector2(randf_range(game.map_x, game.map_width/2), randf_range(game.map_y, game.map_height/2))

	pufferfish.name = "Pufferfish" + str(id)
	get_parent().add_child(pufferfish)
	id += 1
	
func spawn_jellyfish() -> void:
	var jellyfish = jellyfish_scene.instantiate()
	jellyfish.position = Vector2(randf_range(game.map_x, game.map_width/2), randf_range(game.map_y, game.map_height/2))
	jellyfish.name = "Jellyfish" + str(id)
	get_parent().add_child(jellyfish)
	id += 1
	
func spawn_mobs():
	var enemy_count = 0
	while difficulty > 0:
		var index = randi_range(0, mobs.size()-1)
		
		difficulty -= difficulties[index]
		var mob_name = mobs[index]
		if mob_name == "Pufferfish":
			spawn_pufferfish()
		elif mob_name == "Jellyfish":
			spawn_jellyfish()
		enemy_count += 1
	get_parent().num_enemies = enemy_count

func spawnBubble():
	var bubble = bubble_scene.instantiate()
	bubble.position = Vector2(0, 0)
	bubble.name = "Bubble" + str(id)
	bubble.rotation = PI
	get_parent().add_child(bubble)
	id += 1

func _on_timer_timeout() -> void:
	spawn_mobs()
