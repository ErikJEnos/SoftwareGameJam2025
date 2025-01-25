extends StaticBody2D

@export var health: float = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func RemoveHealth(damage: float) -> void:
	health -= damage
	if(health <= 0):
		queue_free()
