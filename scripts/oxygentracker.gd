extends Node2D

var OXYGEN_LEVEL: float = 100.0
var OXYGEN_DECREASE_RATE: float = 5.0

func _process(delta: float) -> void:
	# Decrease the oxygen level
	OXYGEN_LEVEL -= OXYGEN_DECREASE_RATE * delta

	# Ensure oxygen level doesn't go below 0
	OXYGEN_LEVEL = max(OXYGEN_LEVEL, 0)

	#Print the current oxygen level (for debugging)
	#print("OXYGEN_LEVEL: ", OXYGEN_LEVEL)

	# Check if oxygen level reaches 0
	if (OXYGEN_LEVEL > 60 and OXYGEN_LEVEL < 80):
		get_parent().get_node("UI/Sprite2D").frame = 1
	elif (OXYGEN_LEVEL > 40 and OXYGEN_LEVEL < 60):
		get_parent().get_node("UI/Sprite2D").frame = 2
	elif (OXYGEN_LEVEL > 20 and OXYGEN_LEVEL < 40):
		get_parent().get_node("UI/Sprite2D").frame = 3
	elif (OXYGEN_LEVEL < 20):
		get_parent().get_node("UI/Sprite2D").frame = 4
	if OXYGEN_LEVEL <= 0:
		on_oxygen_depleted()

func reset_oxigen():
	OXYGEN_LEVEL = 100.0
	get_parent().get_node("UI/Sprite2D").frame = 0
	
func on_oxygen_depleted() -> void:
	print("Oxygen depleted! Game over.")
	
	# TODO
	#For now, go back to title screen, should show game over screen
	get_tree().change_scene_to_file("res://scenes/titlescreen.tscn")
