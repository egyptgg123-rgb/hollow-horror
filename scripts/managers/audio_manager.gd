# audio_manager.gd - Управление звуками игры
extends Node

var sound_effects = {}
var ambient_player: AudioStreamPlayer = null

func _ready():
	# Загрузка звуков
	load_sound("pistol_shot", "res://assets/sounds/pistol.ogg")
	load_sound("shotgun_shot", "res://assets/sounds/shotgun.ogg")
	load_sound("ice_shot", "res://assets/sounds/ice.ogg")
	load_sound("footstep", "res://assets/sounds/footstep.ogg")
	load_sound("player_hit", "res://assets/sounds/player_hit.ogg")
	load_sound("player_death", "res://assets/sounds/death.ogg")
	load_sound("monster_growl", "res://assets/sounds/growl.ogg")
	load_sound("monster_attack", "res://assets/sounds/attack.ogg")
	load_sound("monster_death", "res://assets/sounds/monster_death.ogg")
	load_sound("equip_pistol", "res://assets/sounds/equip.ogg")
	load_sound("equip_shotgun", "res://assets/sounds/equip.ogg")
	load_sound("equip_ice", "res://assets/sounds/equip.ogg")
	load_sound("victory", "res://assets/sounds/victory.ogg")

func load_sound(name: String, path: String):
	if ResourceLoader.exists(path):
		sound_effects[name] = load(path)

func play_sound(sound_name: String, volume_db: float = 0.0):
	if sound_name not in sound_effects:
		return
	
	var player = AudioStreamPlayer.new()
	player.stream = sound_effects[sound_name]
	player.bus = "SoundEffects"
	player.volume_db = volume_db
	add_child(player)
	player.play()
	
	await player.finished
	player.queue_free()

func play_ambient(sound_name: String, volume_db: float = -10.0):
	if ambient_player:
		ambient_player.queue_free()
	
	ambient_player = AudioStreamPlayer.new()
	if sound_name == "horror_ambient":
		# Создаем генератор звука для атмосферы
		ambient_player.stream = generate_horror_ambient()
	
	ambient_player.bus = "Ambient"
	ambient_player.volume_db = volume_db
	add_child(ambient_player)
	ambient_player.play()

func generate_horror_ambient() -> AudioStream:
	# Генерируем низкочастотный звук ужаса
	var audio = AudioStreamGenerator.new()
	audio.sample_rate = 44100
	audio.buffer_length = 2.0
	return audio

func stop_ambient():
	if ambient_player:
		ambient_player.stop()

func set_master_volume(db: float):
	AudioServer.set_bus_mute(0, false)
	AudioServer.set_bus_volume_db(0, db)
