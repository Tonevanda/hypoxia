extends CharacterBody2D

const SPEED = 6000.0
var collidingEntities = []
var animation_state = "run"
var animation_time = 0.0
var projectileId = 1
const invincibility_duration = 2.0
var invincibility_time = 0.0
var isInvincible = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var projectile_scene = preload("res://scenes/projectile.tscn")

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
	if v_direction:
		velocity.y = v_direction * SPEED

func clearVelocity():
	velocity.x = 0
	velocity.y = 0
	
func animateOnTimer(delta, timeLimit):
	animation_time += delta
	if animation_time >= timeLimit:
		animation_state = "idle"
		animation_time = 0

func _animate(delta: float):
	animated_sprite.play(animation_state)
	var h_direction := Input.get_axis("ui_left", "ui_right")
	var v_direction := Input.get_axis("ui_up", "ui_down")
	if animation_state == "hurt":
		animateOnTimer(delta, 0.3)
	elif animation_state == "attack":
		animateOnTimer(delta, 0.65)
	elif h_direction == 0 and v_direction == 0:
		animation_state = "idle"
	else:
		animation_state = "run"
		
	
	if isInvincible:
		invincibility_time += delta
	if invincibility_time >= invincibility_duration:
		invincibility_time = 0.0
		print("not invincible")
		isInvincible = false


func _start_attack() -> void:
	if animation_state == "attack": # Prevent starting another attack if already attacking
		return
	animation_state = "attack"
	animated_sprite.play("attack")
	var projectile = projectile_scene.instantiate()
	projectile.name = "Projectile" + str(projectileId)
	get_parent().add_child(projectile)
	projectileId += 1
	
func handleCollisions(delta: float):
	for entity in collidingEntities:
		print(entity)
		if entity.name.begins_with("Pufferfish"):
			if !isInvincible:
				animation_state = "hurt"
				get_parent().HEALTH -= 1
				isInvincible = true
			entity.animation_state = "attack"
		elif entity.name.begins_with("Whale"):
			if !isInvincible:
				animation_state = "hurt"
				get_parent().HEALTH -= 2
				isInvincible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack"):
		_start_attack()

func _physics_process(delta: float) -> void:
	handleCollisions(delta)
	_flipH()
	_update_velocity()
	_animate(delta)
	move_and_slide()
	clearVelocity()
