extends Node2D

@export var BlockCount: int = 20

var box_scene = preload("res://Prefabs/Box.tscn")

var enemyBox = preload("res://Prefabs/EnemyBox.tscn")

@export var radius: float = 100.0

@export var rows: int = 50

@export var box_width: float = 60.0

@export var eachLayer: Array = []

var inProgress = false

var levelCount = 0

var num_boxes
var rowCount: int = 0
signal LevelFinished

func _ready() -> void:
	num_boxes = calculate_num_boxes(radius, box_width)
	spawn_boxes_in_circle()


func calculate_num_boxes(radius: float, box_width: float) -> int:
	# Calculate the circumference of the circle
	var circumference = 2 * PI * radius
	# Calculate the number of boxes needed
	return ceil(circumference / box_width)

func spawn_boxes_in_circle():
	SpawnBlocks(5, 6,"b1ffae")
	SpawnEnemyBlocks(3, 15)
	SpawnBlocks(5, 10, "1f51ff")
	SpawnEnemyBlocks(3, 15)


func RemoveBlockFromCount() -> void :
	BlockCount -= 1
	if (BlockCount <= 0):
		Test()
		
func SpawnBlocks(_rows: int = 5, health: int = 5, _color: Color = "ffffff"):
	for x in range(_rows):
		radius += rows
		num_boxes = calculate_num_boxes(radius, box_width)
		var eachRow = Array()
		eachLayer.append(eachRow)
		for i in range(num_boxes):
			# Calculate the angle for this box (in radians)
			var angle = i * TAU / num_boxes
			
			# Calculate the position of the box
			var pos_x = radius * cos(angle)
			var pos_y = radius * sin(angle)
			var position = Vector2(pos_x, pos_y)
			
			var spawnRandomEnemy = randf_range(0, 30)
			var box

			box = box_scene.instantiate()
			box.global_position = position
			box.initialize(health, false, _color)
				
			eachLayer[rowCount].append(box)
			# Rotate the box to face the center
			box.look_at(Vector2(0, 0))
			
			# Add the box as a child
			add_child(box)
		rowCount+=1

func SpawnEnemyBlocks(_rows: int = 5, health: int = 5, _color: Color = "ffffff"): 
	for x in range(_rows):
		print(x)
		radius += rows
		num_boxes = calculate_num_boxes(radius, box_width)
		var eachRow = Array()
		eachLayer.append(eachRow)
		for i in range(num_boxes):
			# Calculate the angle for this box (in radians)
			var angle = i * TAU / num_boxes
			
			# Calculate the position of the box
			var pos_x = radius * cos(angle)
			var pos_y = radius * sin(angle)
			var position = Vector2(pos_x, pos_y)

			var box = enemyBox.instantiate()
			box.global_position = position
			box.initialize(health, true, _color)
			box.canTakeDamage = false
			eachLayer[rowCount].append(box)
			
			# Rotate the box to face the center
			box.look_at(Vector2(0, 0))
			
			# Add the box as a child
			add_child(box)
		if(x == _rows-1):
			SpawnBlocks(1,100000,"000000")
		rowCount+=1
	pass

func Test():
	
	if(inProgress):
		return
	inProgress = true
	
	BlockCount = 10 
	
	print("Level Count: " , levelCount , " Size: ", eachLayer[levelCount].size())
	
	for i in range(eachLayer[levelCount].size()):
		if(eachLayer[levelCount][i] != null):
			eachLayer[levelCount][i].PlayAnimation()
			
			await get_tree().create_timer(0.1).timeout
	
	levelCount = levelCount + 1
	
	if(levelCount >= 5):
		for i in range(eachLayer[levelCount].size()):
			if(eachLayer[levelCount][i] != null):
				eachLayer[levelCount][i].Flash()
		BossIntroFlashing()
	if(levelCount == 8):
		var upgradePanel = get_node("/root/GameNode/UpgradePanel")
		upgradePanel.visible  = true
	if(levelCount == 13):
		get_node("/root/GameNode/WarningCircle").Flashing()
	
	inProgress = false
	
func BossIntroFlashing():
	var _text = get_node("/root/GameNode/Label")
	_text.text = "Boss Time"
	pass


	
