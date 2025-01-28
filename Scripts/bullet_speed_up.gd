extends Node2D

var bulletSpeedUp: float = 1.05

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print(body.name)
		body.BulletSpeedUp(bulletSpeedUp)
		queue_free()
	pass # Replace with function body.
