# game_state.gd - Управление состоянием игры
extends Node

signal health_changed(new_health)
signal ammo_changed(new_ammo)
signal score_changed(new_score)
signal game_over_signal(victory)

var score: int = 0
var current_health: int = 100
var current_ammo: int = 999
var level: int = 1
var is_game_over: bool = false

func _ready():
	pass

func update_health(new_health: int):
	current_health = new_health
	health_changed.emit(new_health)

func update_ammo(new_ammo: int):
	current_ammo = new_ammo
	ammo_changed.emit(new_ammo)

func add_score(amount: int):
	score += amount
	score_changed.emit(score)

func next_level():
	level += 1

func game_over(victory: bool):
	is_game_over = true
	game_over_signal.emit(victory)
	
	if victory:
		print("VICTORY! Score: ", score)
		AudioManager.play_sound("victory")
	else:
		print("GAME OVER! Score: ", score)
		AudioManager.play_sound("player_death")

func reset():
	score = 0
	current_health = 100
	current_ammo = 999
	level = 1
	is_game_over = false
