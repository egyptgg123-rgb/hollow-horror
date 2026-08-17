# enemy_base.gd - Базовый класс врага
extends CharacterBody3D

class_name Enemy

@export var enemy_type: String = "stalker" # stalker, crawler, shadow
@export var health: int = 50
@export var damage: int = 10
@export var speed: float = 5.0
@export var detection_range: float = 30.0
@export var attack_range: float = 2.0
@export var attack_cooldown: float = 1.5

var max_health: int
var player: CharacterBody3D
var can_attack: bool = true
var is_alive: bool = true
var velocity_y: float = 0.0
var gravity: float = 9.8

# AI состояние
var detected_player: bool = false
var last_player_position: Vector3

func _ready():
	add_to_group("enemy")
	max_health = health
	player = get_tree().root.get_child(0).find_child("Player", true, false)
	
	match enemy_type:
		"stalker":
			modulate = Color.WHITE
			speed = 6.0
		"crawler":
			modulate = Color(0.5, 0.5, 0.5)
			speed = 8.0
		"shadow":
			modulate = Color(0.2, 0.2, 0.2)
			speed = 7.0

func _physics_process(delta):
	if not is_alive or not player:
		return
	
	var distance_to_player = global_position.distance_to(player.global_position)
	
	# Обнаружение игрока
	if distance_to_player < detection_range:
		detected_player = true
		last_player_position = player.global_position
	else:
		detected_player = false
	
	# Поведение
	if detected_player:
		chase_player(delta)
		
		if distance_to_player < attack_range:
			attack_player()
	else:
		patrol(delta)
	
	# Гравитация
	if not is_on_floor():
		velocity_y -= gravity * delta
	else:
		velocity_y = 0
	
	velocity.y = velocity_y
	move_and_slide()

func chase_player(delta):
	var direction = (player.global_position - global_position).normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	# Звуки охоты
	if randf() < 0.05:
		AudioManager.play_sound("monster_growl")

func patrol(delta):
	# Случайное патрулирование
	velocity.x = 0
	velocity.z = 0

func attack_player():
	if can_attack:
		can_attack = false
		player.take_damage(damage)
		AudioManager.play_sound("monster_attack")
		
		await get_tree().create_timer(attack_cooldown).timeout
		can_attack = true

func take_damage(amount: int, hit_position: Vector3 = Vector3.ZERO):
	if not is_alive:
		return
	
	health -= amount
	
	# Кровь и эффекты
	var blood_effect = load("res://scenes/effects/blood_effect.tscn").instantiate()
	get_parent().add_child(blood_effect)
	blood_effect.global_position = hit_position
	
	# Вспышка красного при урона
	var tween = create_tween()
	modulate = Color.RED
	tween.tween_callback(func(): modulate = Color.WHITE)
	
	if health <= 0:
		die()

func die():
	is_alive = false
	AudioManager.play_sound("monster_death")
	
	# Анимация смерти
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.5)
	await tween.finished
	queue_free()
	
	GameState.add_score(100)
