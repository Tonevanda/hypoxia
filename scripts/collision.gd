extends Area2D


func _on_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	print(get_parent())
	area_parent.collidingEntities.append(get_parent())


func _on_area_exited(area: Area2D) -> void:
	var area_parent = area.get_parent()
	for entity in area_parent.collidingEntities:
		if entity.name == get_parent().name:
			area_parent.collidingEntities.erase(entity)
			break
