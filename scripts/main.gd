# main.gd - Главная сцена игры
extends Node3D

@onready var player = $Player
@onready var camera = $Player/Camera3D
@onready var ui_layer = $CanvasLayer
@onready var monster_spawner = $MonsterSpawner

var current_level = 1
var story_text = [
	"ТЫ ОЧНУЛСЯ В ТЕМНОТЕ...",
	"Неясные звуки раздаются из тьмы. Что-то здесь не так.",
	"В руках ты чувствуешь холодный металл... оружие.",
	"Свет! Впереди виднеется свет, но...",
	"ЧТО-ТО ПРИБЛИЖАЕТСЯ..."
]

func _ready():
	AudioManager.play_ambient("horror_ambient", -10)
	show_story_text(0)
	setup_level()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func setup_level():
	monster_spawner.setup_spawn_points()
	await get_tree().create_timer(3.0).timeout
	monster_spawner.spawn_wave(current_level)

func show_story_text(index: int):
	if index < story_text.size():
		var label = Label.new()
		label.text = story_text[index]
		label.add_theme_font_size_override("font_size", 32)
		label.anchor_left = 0.5
		label.anchor_top = 0.5
		label.offset_left = -200
		label.offset_top = -50
		label.custom_minimum_size = Vector2(400, 100)
		ui_layer.add_child(label)
		
		var tween = create_tween()
		tween.tween_property(label, "modulate:a", 1.0, 0.5)
		tween.tween_callback(func(): await get_tree().create_timer(2.0).timeout)
		tween.tween_property(label, "modulate:a", 0.0, 0.5)
		await tween.finished
		label.queue_free()
		
		show_story_text(index + 1)
