extends CharacterBody2D  # Use KinematicBody2D for Godot 3.x

# Movement speed
@export var speed: float = 200.0
@export var bulletSpeed: float = 300.0
@export var bulletDamage: float = 5.0

var can_shoot = false
@export var fireRate: float = 0.5
var can_fire: bool = false  # Control firing rate

var bullet_scene = preload("res://Prefabs/Bullet.tscn")
var Bullet = "res://Scripts/Bullet.gd"


func _process(delta: float) -> void:
	var input_vector = Vector2.ZERO

	# Get input for all four directions
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if Input.is_action_pressed("fire"):  # Replace "fire" with your custom action
		print("Fire")
		fire_bullet(get_global_mouse_position())
	
	# Normalize to ensure consistent speed in all directions
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	# Apply movement
	velocity = input_vector * speed
	move_and_slide()

func fire_bullet(target_position: Vector2) -> void:
	if can_fire:
		return  # Prevent shooting if the timer isn't ready
	
	can_fire = true
	
	# Instance the bullet
	var bullet = bullet_scene.instantiate()
	bullet.initialize(bulletDamage,bulletSpeed)
	get_tree().root.add_child(bullet)

	# Set bullet position to player's position + offset
	bullet.global_position = global_position

	# Calculate direction from player to mouse click
	var direction = target_position - bullet.global_position

	# Fire the bullet
	bullet.fire(direction)
	
	await get_tree().create_timer(fireRate).timeout
	can_fire = false

func FireRateUp(rateUp: float) -> void:
	print("FireRate Increase Old: ", fireRate, " New: ", fireRate - rateUp)
	fireRate -= rateUp

func DamageUp(damageUp: float) -> void:
	print("BulletDamage Increase Old: ", bulletDamage, " New: ", bulletDamage + damageUp)
	bulletDamage += damageUp

func BulletSpeedUp(bulletSpeedUp: float) -> void:
	print("BulletSpeed Increase Old: ", bulletSpeed, " New: ", bulletSpeed + bulletSpeedUp)
	bulletSpeedUp += bulletSpeedUp

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		fire_bullet(event.position)
