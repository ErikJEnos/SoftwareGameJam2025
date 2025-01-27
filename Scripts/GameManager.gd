extends Node2D

@export var BlockCount: int = 2

var box_scene = preload("res://Prefabs/Box.tscn")

@export var radius: float = 100.0

@export var rows: int = 50

@export var box_width: float = 60.0

@export var eachLayer: Array = []

var levelCount = 0

signal LevelFinished

func _ready() -> void:
	var num_boxes = calculate_num_boxes(radius, box_width)
	spawn_boxes_in_circle(num_boxes)


func calculate_num_boxes(radius: float, box_width: float) -> int:
	# Calculate the circumference of the circle
	var circumference = 2 * PI * radius
	# Calculate the number of boxes needed
	return ceil(circumference / box_width)

func spawn_boxes_in_circle(num_boxes: int):
	var test: int = 0
	for x in range(rows):
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
			
			# Instance the box scene
			var box = box_scene.instantiate()
			box.global_position = position
			eachLayer[test].append(box)
			
			# Rotate the box to face the center
			box.look_at(Vector2(0, 0))
			
			# Add the box as a child
			add_child(box)
		test += 1 
		
	print("How many rows ", eachLayer.size(), " : ", eachLayer[0].size(), " : ", eachLayer[0][0].name)


func RemoveBlockFromCount() -> void :
	BlockCount -= 1
	if (BlockCount == 0):
		Test()
		


func Test():
	
	BlockCount = 10 
	
	print("Level Count: " , levelCount , " Size: ", eachLayer[levelCount].size())
	
	for i in range(eachLayer[levelCount].size()):
		if(eachLayer[levelCount][i] != null):
			eachLayer[levelCount][i].queue_free()
			
			await get_tree().create_timer(0.1).timeout
	
	levelCount = levelCount + 1
