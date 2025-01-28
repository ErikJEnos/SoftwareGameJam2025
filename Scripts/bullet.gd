extends RigidBody2D

@export var speed: float = 300.0  # Speed of the bullet
@export var damage: float = 5.0  # damage of the bullet
@export var bounceCount: int = 1

var collided_bodies: Array = []

@onready var animation = $AnimationPlayer

func initialize(_damage: float, _speed: float, _bounceCount: int):
	speed = _speed
	damage = _damage
	bounceCount = _bounceCount


func fire(direction: Vector2) -> void:
	# Apply an impulse to move the bullet
	linear_velocity = direction.normalized() * speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	 # Check if the body is a wall and if it hasn't been collided with yet
	if body.is_in_group("Wall"):

		# Apply damage to the body
		body.RemoveHealth(damage)

		# Only decrement bounceCount once
		bounceCount -= 1
		
		# If bounceCount reaches zero, remove the bullet
		if bounceCount <= 0:
			linear_velocity = Vector2(0,0)* speed
			animation.play("BulletDestroyed")
			
