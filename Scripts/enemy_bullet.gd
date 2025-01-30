extends RigidBody2D

@export var speed: float = 300.0  # Speed of the bullet
@export var damage: float = 5.0  # damage of the bullet

var selfNode 

func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = 3.0
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer) 
	timer.start()
	pass # Replace with function body.

func _on_timer_timeout():
		queue_free()

func initialize(_damage: float, _speed: float, _selfNode):
	speed = _speed
	damage = _damage
	selfNode = _selfNode

func fire(direction: Vector2) -> void:

	# Apply an impulse to move the bullet
	linear_velocity = direction.normalized() * speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Hiting player")
		if(body.CheckHurt()):
			body.RemovePlayerHealth(damage)
			queue_free()
		
