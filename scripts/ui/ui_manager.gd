# ui_manager.gd - Система UI
extends CanvasLayer

@onready var health_label = Label.new()
@onready var ammo_label = Label.new()
@onready var score_label = Label.new()
@onready var crosshair = Label.new()

func _ready():
	setup_labels()
	GameState.health_changed.connect(_on_health_changed)
	GameState.ammo_changed.connect(_on_ammo_changed)
	GameState.score_changed.connect(_on_score_changed)

func setup_labels():
	# Здоровье
	health_label.text = "HP: 100"
	health_label.add_theme_font_size_override("font_size", 28)
	health_label.position = Vector2(20, 20)
	add_child(health_label)
	
	# Амуниция
	ammo_label.text = "AMMO: 999"
	ammo_label.add_theme_font_size_override("font_size", 28)
	ammo_label.position = Vector2(20, 60)
	add_child(ammo_label)
	
	# Очки
	score_label.text = "SCORE: 0"
	score_label.add_theme_font_size_override("font_size", 28)
	score_label.position = Vector2(20, 100)
	add_child(score_label)
	
	# Прицел
	crosshair.text = "+"
	crosshair.add_theme_font_size_override("font_size", 40)
	crosshair.anchor_left = 0.5
	crosshair.anchor_top = 0.5
	crosshair.offset_left = -10
	crosshair.offset_top = -15
	add_child(crosshair)

func _on_health_changed(new_health: int):
	health_label.text = "HP: %d" % new_health
	
	# Красим в красный если мало здоровья
	if new_health < 30:
		health_label.add_theme_color_override("font_color", Color.RED)
	else:
		health_label.add_theme_color_override("font_color", Color.WHITE)

func _on_ammo_changed(new_ammo: int):
	ammo_label.text = "AMMO: %d" % new_ammo

func _on_score_changed(new_score: int):
	score_label.text = "SCORE: %d" % new_score

func show_message(message: String, duration: float = 3.0):
	var msg_label = Label.new()
	msg_label.text = message
	msg_label.add_theme_font_size_override("font_size", 32)
	msg_label.anchor_left = 0.5
	msg_label.anchor_top = 0.5
	msg_label.offset_left = -150
	msg_label.offset_top = -50
	msg_label.custom_minimum_size = Vector2(300, 100)
	add_child(msg_label)
	
	var tween = create_tween()
	tween.tween_property(msg_label, "modulate:a", 1.0, 0.3)
	tween.tween_callback(func(): await get_tree().create_timer(duration - 0.6).timeout)
	tween.tween_property(msg_label, "modulate:a", 0.0, 0.3)
	await tween.finished
	msg_label.queue_free()
