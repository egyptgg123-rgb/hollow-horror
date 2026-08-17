# monster_spawner.gd - Система спавна врагов
extends Node3D

class_name MonsterSpawner

@export var spawn_points: Array[Vector3] = []
@export var wave_size_start: int = 3
@export var wave_increase: int = 2

var current_wave: int = 0
var enemies_alive: int = 0
var spawned_enemies: Array = []

var enemy_types = ["stalker", "crawler", "shadow"]

func _ready():
	setup_spawn_points()

func setup_spawn_points():
	# Точки спавна по сцене
	spawn_points = [
		Vector3(-10, 1, -10),
		Vector3(10, 1, -10),
		Vector3(-10, 1, 10),
		Vector3(10, 1, 10),
		Vector3(0, 1, -15),
		Vector3(0, 1, 15),
		Vector3(-15, 1, 0),
		Vector3(15, 1, 0),
	]

func spawn_wave(wave_num: int):
	current_wave = wave_num
	var enemies_to_spawn = wave_size_start + (wave_num - 1) * wave_increase
	
	GameState.update_health(100)
	AudioManager.play_ambient("horror_ambient")
	
	for i in range(enemies_to_spawn):
		await get_tree().create_timer(0.5).timeout
		spawn_enemy(wave_num)

func spawn_enemy(wave_num: int):
	var enemy_scene = load("res://scenes/enemies/enemy.tscn")
	if not enemy_scene:
		return
	
	var enemy = enemy_scene.instantiate()
	
	# Случайный тип врага в зависимости от волны
	if wave_num < 2:
		enemy.enemy_type = "stalker"
	elif wave_num < 4:
		enemy.enemy_type = enemy_types[randi() % 2]
	else:
		enemy.enemy_type = enemy_types[randi() % 3]
	
	# Случайная точка спавна
	var spawn_point = spawn_points[randi() % spawn_points.size()]
	enemy.position = spawn_point
	
	add_child(enemy)
	spawned_enemies.append(enemy)
	enemies_alive += 1
	
	enemy.tree_exited.connect(func(): enemies_alive -= 1)

func all_waves_cleared() -> bool:
	return enemies_alive == 0 and current_wave >= 3

func get_enemies_count() -> int:
	return enemies_alive
