extends CharacterBody2D

const SPEED = 6000.0
var prev_direction = 1
var collidingEntities = []
var animation_state = "run"
var attack_time = 0.0  # Timer for attack animation duration
var projectileId = 1

@onready var animated_sprite = $AnimatedSprite2D
@onready var projectile_scene = preload("res://scenes/projectile.tscn")

func _flipH() -> void:
	var h_direction := Input.get_axis("ui_left", "ui_right")
	if h_direction < 0:
		animated_sprite.flip_h = false
	elif h_direction > 0:
		animated_sprite.flip_h = true

func _update_velocity() -> void:
	var h_direction := Input.get_axis("ui_left", "ui_right")
	var v_direction := Input.get_axis("ui_up", "ui_down")
	if h_direction:
		velocity.x = h_direction * SPEED
	if v_direction:
		velocity.y = v_direction * SPEED
	if h_direction == 0 and v_direction == 0 and animation_state != "attack":
		animation_state = "idle"
	elif animation_state != "attack":
		animation_state = "run"

func clearVelocity():
	velocity.x = 0
	velocity.y = 0

func _animate(delta: float):
	animated_sprite.play(animation_state)
	if animation_state == "attack":
		attack_time += delta
		# Retard hard-coded value, I'm a Godot noob whatever
		if attack_time >= 0.65:
			# Attack animation is finished, reset
			animation_state = "idle"


func _start_attack() -> void:
	if animation_state == "attack":  # Prevent starting another attack if already attacking
		return
	animation_state = "attack"
	attack_time = 0.0  # Reset the attack timer
	animated_sprite.play("attack")
	var projectile = projectile_scene.instantiate()
	projectile.position = position
	if animated_sprite.flip_h:	
		projectile.set_direction(1)
	else:
		projectile.set_direction(-1)
	projectile.name = "Projectile" + str(projectileId)
	get_parent().add_child(projectile)
	projectileId += 1
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		_start_attack()

func _physics_process(delta: float) -> void:
	_flipH()
	_update_velocity()
	_animate(delta)
	move_and_slide()
	clearVelocity()
	collidingEntities = []
