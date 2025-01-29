extends StaticBody2D

@export var health: float = 5.0
@export var maxHealth: float = 5.0
@export var isEnemy: = false
var canTakeDamage = true

@onready var damagedBlock = $SpriteDamage
@onready var animation = $AnimationPlayer
@onready var blockhit: AudioStreamPlayer = $blockhit
@onready var blockbreak: AudioStreamPlayer = $blockbreak
@onready var enemy_shoot: AudioStreamPlayer = $enemyShoot


var enemyBullet = preload("res://Prefabs/EnemyBullet.tscn")

var allPowerUps = [
	preload("res://Prefabs/PowerUps/BulletSpeedUp.tscn"),
	preload("res://Prefabs/PowerUps/DamageUp.tscn"),
	preload("res://Prefabs/PowerUps/FireRateUp.tscn"),
]


func initialize(_health: float, _isEnemy: bool, _Color: Color):
	health = _health
	maxHealth = _health
	isEnemy = _isEnemy
	modulate = _Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func RemoveHealth(damage: float) -> void:
	if(canTakeDamage):
		
		health -= damage


		if(isEnemy):
			ShootAtPlayer()
			modulate = Color(0.5, 0.5, 0.5)
		else:
			blockhit.play()
			await blockhit.finished
			damagedBlock.visible = true
			GetHealthPer()
			

		if(health <= 0):
			GameManager.RemoveBlockFromCount()
			spawn_random_power_up()
			PlayAnimation()

func _deferred_spawn_random_power_up():
	var random = randf_range(0, allPowerUps.size() + 30)
	if(random <= allPowerUps.size()):
		var power_up_scene = allPowerUps[random]
		var power_up = power_up_scene.instantiate()
		get_tree().root.add_child(power_up)
		power_up.global_position = global_position

func spawn_random_power_up():
	# This is where you might be modifying a physics state like a collision shape
	call_deferred("_deferred_spawn_random_power_up")
	
func ShootAtPlayer():
	#enemy_shoot.play() erik pls fix this
	var bullet = enemyBullet.instantiate()
	bullet.initialize(1, 300, self)
	get_tree().root.add_child(bullet)

	# Set bullet position to player's position
	bullet.global_position = global_position
	var player = get_node("/root/GameNode/Player")
	var direction = (player.global_position - bullet.global_position).normalized()

	# Fire the bullet with the adjusted direction
	bullet.fire(direction)

func Flash():
	if($Sprite2D2 != null):
		for i in range(10):
			$Sprite2D2.visible = true
			await get_tree().create_timer(0.1).timeout
			$Sprite2D2.visible = false
			await get_tree().create_timer(0.1).timeout
		canTakeDamage = true
	pass 

func GetHealthPer():
	var percent = (health / maxHealth) * 100.0
	if(percent >= 75):
		$SpriteDamage.frame = 0
	elif(percent <= 75 && percent >= 50):
		$SpriteDamage.frame = 1
	elif(percent < 45):
		$SpriteDamage.frame = 2

func PlayAnimation(): 
	if(not isEnemy):
		blockbreak.play()
		animation.play("Destroyed")
	else:
		blockbreak.play()
		animation.play("BossDestroyed")
