extends Node2D
@onready var powerup: AudioStreamPlayer = $powerup


var damageUp: float = 0.2
func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Player")):
		print(body.name)
		body.DamageUp(damageUp)
		powerup.play()
		await powerup.finished
		queue_free()
	pass # Replace with function body.
