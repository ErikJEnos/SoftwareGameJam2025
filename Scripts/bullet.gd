extends RigidBody2D

@export var speed: float = 100.0  # Speed of the bullet

func fire(direction: Vector2) -> void:
	# Apply an impulse to move the bullet
	linear_velocity = direction.normalized() * speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Wall"):
		body.queue_free()
		queue_free()
