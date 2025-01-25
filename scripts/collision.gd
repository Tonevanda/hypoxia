extends Area2D




func _on_area_entered(area: Area2D) -> void:
	area.get_parent().isColliding = true


func _on_area_exited(area: Area2D) -> void:
	area.get_parent().isColliding = false
	
