extends Node2D

@onready var spriteFlashing = $Sprite2D
@onready var spawnnerSprite = $Sprite2D2
@onready var spawnner = $Sprite2D2/StaticBody2D

@onready var rayCast2D = $Sprite2D2/LaserPivotPoint/RayCast2D
@onready var line2D = $Sprite2D2/LaserPivotPoint/Line2D
@onready var laser = $Sprite2D2/LaserPivotPoint/Laser
@onready var laserPivot = $Sprite2D2/LaserPivotPoint
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line2D.points.clear()
	line2D.show()
	line2D.add_point(rayCast2D.position)
	line2D.add_point(rayCast2D.target_position)
	pass # Replace with function body.

func  _physics_process(delta: float) -> void:
	if rayCast2D.is_colliding():
		var collider = rayCast2D.get_collider()
		var colPoint = rayCast2D.get_collision_point()
		var localColPoint = to_local(colPoint)

		line2D.default_color = Color.RED
		
		print(localColPoint)
		laser.global_position.y = localColPoint.y
		laserPivot.global_position.y = localColPoint.y
		

	else:
		line2D.default_color = Color.GREEN

		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Flashing(): 
	if($Sprite2D != null):
		for i in range(10):
			$Sprite2D.visible = true
			await get_tree().create_timer(0.1).timeout
			$Sprite2D.visible = false
			await get_tree().create_timer(0.1).timeout
		ShowSpanner()
	else: 
		print("Null")
func ShowSpanner():
	spawnnerSprite.visible = true
	spawnner.collision_layer = 1
