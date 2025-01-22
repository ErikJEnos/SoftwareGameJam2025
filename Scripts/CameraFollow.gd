extends Camera2D

# Smooth follow settings
@export var enable_smoothing: bool = true
@export var smoothing_speed: float = 5.0


func _process(delta: float) -> void:
	if enable_smoothing:
		global_position = lerp(global_position, get_parent().global_position, smoothing_speed * delta)
	else:
		global_position = get_parent().global_position
