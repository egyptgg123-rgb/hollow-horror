# player.gd - Основные системы игрока
extends CharacterBody3D

# Параметры
@export var speed: float = 7.0
@export var sprint_speed: float = 12.0
@export var max_health: int = 100
@export var mouse_sensitivity: float = 0.003

# Состояние
var health: int
var is_alive: bool = true
var camera_rotation: Vector3 = Vector3.ZERO
var velocity_y: float = 0.0
var gravity: float = 9.8

# Ссылки
@onready var camera = $Camera3D
@onready var weapon = $Weapon
@onready var raycast = $Camera3D/RayCast3D

# Звуки
var footstep_timer: float = 0.0
var is_moving: bool = false

func _ready():
	health = max_health
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Настройка оружия
	weapon.player = self

func _physics_process(delta):
	if not is_alive:
		return
	
	# Движение
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var current_speed = sprint_speed if Input.is_action_pressed("ui_sprint") else speed
	
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		is_moving = true
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		is_moving = false
	
	# Гравитация
	if not is_on_floor():
		velocity_y -= gravity * delta
	else:
		velocity_y = 0
	
	velocity.y = velocity_y
	move_and_slide()
	
	# Атака
	if Input.is_action_pressed("ui_attack"):
		weapon.attack()
	
	# Звуки шагов
	update_footsteps(delta)

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		camera_rotation.y -= event.relative.x * mouse_sensitivity
		camera_rotation.x -= event.relative.y * mouse_sensitivity
		camera_rotation.x = clamp(camera_rotation.x, -PI/2, PI/2)
		
		rotation.y = camera_rotation.y
		camera.rotation.x = camera_rotation.x
	
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func take_damage(amount: int):
	if not is_alive:
		return
	
	health -= amount
	health = max(0, health)
	
	AudioManager.play_sound("player_hit")
	GameState.update_health(health)
	
	if health <= 0:
		die()

func die():
	is_alive = false
	AudioManager.play_sound("player_death")
	GameState.game_over(false)
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func update_footsteps(delta):
	if is_moving and is_on_floor():
		footstep_timer -= delta
		if footstep_timer <= 0:
			AudioManager.play_sound("footstep")
			footstep_timer = 0.4 if Input.is_action_pressed("ui_sprint") else 0.6
