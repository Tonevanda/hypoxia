extends CharacterBody2D


const SPEED = 6000.0
var prev_direction = 1

func _update_velocity(delta: float) -> void:
	var h_direction := Input.get_axis("ui_left", "ui_right")
	var v_direction := Input.get_axis("ui_up", "ui_down")
	if h_direction:
		velocity.x = h_direction * SPEED
		if h_direction != prev_direction:
			scale.x *= -1
			prev_direction = h_direction
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if v_direction:
		velocity.y = v_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	_update_velocity(delta)
	move_and_slide()
