extends RigidBody2D

@export var speed: float = 100.0  # Speed of the bullet
@export var damage: float = 5.0  # damage of the bullet

func initialize(_damage: float, _speed: float):
	speed = _speed
	damage = _damage


func fire(direction: Vector2) -> void:
	# Apply an impulse to move the bullet
	linear_velocity = direction.normalized() * speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Wall"):
		body.RemoveHealth(damage)
		queue_free()
