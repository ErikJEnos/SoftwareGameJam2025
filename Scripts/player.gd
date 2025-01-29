extends CharacterBody2D  # Use KinematicBody2D for Godot 3.x

# Movement speed
@export var speed: float = 400.0
@export var bulletSpeed: float = 300.0
@export var bulletDamage: float = 5.0
@export var bounceCount: int = 2
@export var bulletCount: int = 9
@export var spreadAngle: float = 30  
@export var health: float = 5  
@onready var shoot: AudioStreamPlayer = $"../shoot"
@onready var playerhit: AudioStreamPlayer = $"../playerhit"
@onready var animation = $"../AnimationPlayer"

var canBeHurt = true

var can_shoot = false
@export var fireRate: float = 0.5
var can_fire: bool = false  # Control firing rate

var bullet_scene = preload("res://Prefabs/Bullet.tscn")
var Bullet = "res://Scripts/Bullet.gd"

func _ready() -> void:
	animation.play("Idle")
	pass # Replace with function body.


func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	# Get input for all four directions
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if Input.is_action_pressed("fire"):  # Replace "fire" with your custom action
		fire_bullet(get_global_mouse_position())
	
	# Normalize to ensure consistent speed in all directions
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	# Apply movement
	velocity = input_vector * speed
	move_and_slide()

func fire_bullet(target_position: Vector2) -> void:
	if can_fire:
		return 
	shoot.play()
	
	
	can_fire = true

	var angleStep = spreadAngle / max(1, bulletCount - 1)
	var startAngle = -spreadAngle / 2  # Start at the leftmost angle

	for i in range(bulletCount):
		# Instance each bullet
		var bullet = bullet_scene.instantiate()
		bullet.initialize(bulletDamage, bulletSpeed, bounceCount)
		get_tree().root.add_child(bullet)

		# Set bullet position to player's position
		bullet.global_position = global_position

		# Calculate the direction for the current bullet
		var angle = deg_to_rad(startAngle + i * angleStep)
		var direction = (target_position - bullet.global_position).normalized()
		var rotated_direction = direction.rotated(angle)

		# Fire the bullet with the adjusted direction
		bullet.fire(rotated_direction)
	
	await get_tree().create_timer(fireRate).timeout
	can_fire = false

func FireRateUp(rateUp: float = 0.90) -> void:
	print("FireRate Increase Old: ", fireRate, " New: ", fireRate * rateUp)
	fireRate *= rateUp
	fireRate = fireRate/1

func DamageUp(damageUp: float = 0.2) -> void:
	print("BulletDamage Increase Old: ", bulletDamage, " New: ", bulletDamage + damageUp)
	bulletDamage += damageUp

func BulletSpeedUp(bulletSpeedUp: float = 1.05) -> void:
	print("BulletSpeed Increase Old: ", bulletSpeed, " New: ", bulletSpeed * bulletSpeedUp)
	bulletSpeed *= bulletSpeedUp

func BounceUp() -> void:
	print("Working")
	bounceCount+=1 
	
func BulletCountUp() -> void:
	print("Working")
	bulletCount+=1 

func RemovePlayerHealth(damage: float):
	if canBeHurt:
		animation.play("PlayerHit")
		health -= damage
	
func CanBeHurt():
	canBeHurt = !canBeHurt
	print("canBeHurt: = ", canBeHurt)
	
func CheckHurt() -> bool:
	return canBeHurt


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	animation.play("Idle")
	pass # Replace with function body.
