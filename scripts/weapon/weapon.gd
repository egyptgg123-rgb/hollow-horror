# weapon.gd - Система оружия
extends Node3D

class_name Weapon

@export var weapon_type: String = "pistol" # pistol, shotgun, ice_gun
@export var damage: int = 25
@export var fire_rate: float = 0.3
@export var ammo: int = 999
@export var max_ammo: int = 999

var player: CharacterBody3D
var can_attack: bool = true
var camera: Camera3D

# Позиции выстрела
var muzzle_position: Vector3

func _ready():
	camera = get_parent().get_parent().get_node("Camera3D")
	muzzle_position = Vector3(0.3, 0, -0.5)

func attack():
	if not can_attack or ammo <= 0:
		return
	
	can_attack = false
	ammo -= 1
	GameState.update_ammo(ammo)
	
	match weapon_type:
		"pistol":
			shoot_ray(1, 0.1)
			AudioManager.play_sound("pistol_shot")
		"shotgun":
			shoot_ray(8, 1.0)
			AudioManager.play_sound("shotgun_shot")
		"ice_gun":
			shoot_ice_beam()
			AudioManager.play_sound("ice_shot")
	
	# Отдача камеры
	var tween = create_tween()
	var original_rot = camera.rotation
	camera.rotation.x -= 0.05
	tween.tween_callback(func(): camera.rotation = original_rot)
	
	await get_tree().create_timer(fire_rate).timeout
	can_attack = true

func shoot_ray(ray_count: int, spread: float):
	for i in range(ray_count):
		var spread_angle = randf_range(-spread, spread)
		var direction = camera.global_transform.basis.z * -1
		direction = direction.rotated(Vector3.up, spread_angle)
		direction = direction.rotated(camera.global_transform.basis.x, randf_range(-spread, spread))
		
		var query = PhysicsRayQueryParameters3D.create(
			camera.global_position,
			camera.global_position + direction * 100
		)
		query.exclude = [player]
		
		var result = get_world_3d().direct_space_state.intersect_ray(query)
		
		if result:
			var hit_object = result.collider
			if hit_object.is_in_group("enemy"):
				hit_object.take_damage(damage, result.position)
				create_impact_effect(result.position)

func shoot_ice_beam():
	var direction = camera.global_transform.basis.z * -1
	var ice_projectile = load("res://scenes/projectiles/ice_projectile.tscn").instantiate()
	get_parent().get_parent().add_child(ice_projectile)
	ice_projectile.global_position = camera.global_position + direction * 1
	ice_projectile.set_direction(direction)
	ice_projectile.damage = damage * 2

func create_impact_effect(position: Vector3):
	var impact = load("res://scenes/effects/impact_effect.tscn").instantiate()
	get_parent().get_parent().add_child(impact)
	impact.global_position = position

func heal_ammo(amount: int):
	ammo = min(ammo + amount, max_ammo)
	GameState.update_ammo(ammo)

func switch_weapon(new_type: String):
	weapon_type = new_type
	match new_type:
		"pistol":
			damage = 25
			fire_rate = 0.3
			AudioManager.play_sound("equip_pistol")
		"shotgun":
			damage = 50
			fire_rate = 0.8
			AudioManager.play_sound("equip_shotgun")
		"ice_gun":
			damage = 40
			fire_rate = 0.5
			AudioManager.play_sound("equip_ice")
