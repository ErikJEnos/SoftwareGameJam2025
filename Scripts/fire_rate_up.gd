extends Node2D
@onready var powerup: AudioStreamPlayer = $"../powerup"

var fireRateUp: float = 0.90

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print(body.name)
		body.FireRateUp(fireRateUp)
		powerup.play()
		await powerup.finished
		queue_free()
	pass # Replace with function body.
