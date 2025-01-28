extends Node2D

@onready var spriteFlashing = $Sprite2D
@onready var spawnnerSprite = $Sprite2D2
@onready var spawnner = $Sprite2D2/StaticBody2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
