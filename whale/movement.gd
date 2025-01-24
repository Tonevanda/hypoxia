extends CharacterBody2D


const SPEED = 300.0
var prev_direction = 1

@onready var animated_sprite = $AnimatedSprite2D

func _flipH() -> void:
	var h_direction := Input.get_axis("ui_left", "ui_right")
	if h_direction > 0:
		animated_sprite.flip_h = false
	elif h_direction < 0:
		animated_sprite.flip_h = true

func _update_velocity() -> void:
	var h_direction := Input.get_axis("ui_left", "ui_right")
	var v_direction := Input.get_axis("ui_up", "ui_down")
	if h_direction:
		velocity.x = h_direction * SPEED
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
	_flipH()
	_update_velocity()
	move_and_slide()
