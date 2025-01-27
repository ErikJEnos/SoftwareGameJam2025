extends StaticBody2D

@export var health: float = 5.0

var allPowerUps = [
	preload("res://Prefabs/PowerUps/BulletSpeedUp.tscn"),
	preload("res://Prefabs/PowerUps/DamageUp.tscn"),
	preload("res://Prefabs/PowerUps/FireRateUp.tscn"),
]


func initialize(_health: float):
	health = _health

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func RemoveHealth(damage: float) -> void:
	health -= damage
	modulate = Color(0.5, 0.5, 0.5)
	
	if(health <= 0):
		GameManager.RemoveBlockFromCount()
		spawn_random_power_up()
		queue_free()

func _deferred_spawn_random_power_up():
	var random = randf_range(0, allPowerUps.size() + 30)
	print("rad: ", random)
	if(random <= allPowerUps.size()):
		var power_up_scene = allPowerUps[random]
		var power_up = power_up_scene.instantiate()
		get_tree().root.add_child(power_up)
		power_up.global_position = global_position

func spawn_random_power_up():
	# This is where you might be modifying a physics state like a collision shape
	call_deferred("_deferred_spawn_random_power_up")
