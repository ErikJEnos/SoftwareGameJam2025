extends Node2D

var fireRateUp: float = 0.90

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print(body.name)
		body.FireRateUp(fireRateUp)
		queue_free()
	pass # Replace with function body.
