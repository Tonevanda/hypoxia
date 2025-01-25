extends CharacterBody2D

const SPEED = 6000.0
var prev_direction = 1
var isColliding = false
var is_attacking = false  # Tracks if the character is in the attack state
var attack_time = 0.0  # Timer for attack animation duration

@onready var animated_sprite = $AnimatedSprite2D

func _flipH() -> void:
	var h_direction := Input.get_axis("ui_left", "ui_right")
	if h_direction > 0:
		animated_sprite.flip_h = false
	elif h_direction < 0:
		animated_sprite.flip_h = true

func _update_velocity() -> void:
	if is_attacking:
		velocity.x = 0
		velocity.y = 0
	
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

func _animate():
	if is_attacking:  # Play the attack animation if attacking
		animated_sprite.play("attack")
		return

	var h_direction := Input.get_axis("ui_left", "ui_right")
	var v_direction := Input.get_axis("ui_up", "ui_down")
	if h_direction == 0 and v_direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")

func _start_attack() -> void:
	if is_attacking:  # Prevent starting another attack if already attacking
		return
	is_attacking = true
	attack_time = 0.0  # Reset the attack timer
	animated_sprite.play("attack")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		_start_attack()

func _physics_process(delta: float) -> void:
	if is_attacking:
		attack_time += delta
		# Retard hard-coded value, I'm a Godot noob whatever
		if attack_time >= 0.65:
			# Attack animation is finished, reset
			is_attacking = false
			#_animate()
	_flipH()
	_update_velocity()
	_animate()
	move_and_slide()
