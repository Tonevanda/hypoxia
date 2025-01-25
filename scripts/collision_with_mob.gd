extends Area2D




func _on_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent.name.begins_with("Pufferfish"):
		area.get_parent().isColliding = true


func _on_area_exited(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent.name.begins_with("Pufferfish"):		
		area.get_parent().isColliding = false
	
