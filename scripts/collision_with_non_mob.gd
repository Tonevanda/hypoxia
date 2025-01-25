extends Area2D




func _on_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if !area_parent.name.begins_with("Pufferfish"):		
		area_parent.collidingEntities.append(area_parent)


func _on_area_exited(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if !area_parent.name.begins_with("Pufferfish"):		
		for entity in area_parent.collidingEntities:
			if entity.name == area_parent.name:	
				area_parent.remove(entity)
				break
	
