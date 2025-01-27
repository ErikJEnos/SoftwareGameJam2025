extends Node2D

var damageUp: float = 0.2
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print(body.name)
		body.DamageUp(damageUp)
		queue_free()
	pass # Replace with function body.
