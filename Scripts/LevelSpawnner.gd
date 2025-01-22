extends Node2D

# Box scene to spawn (assign your box scene in the Inspector)
@export var box_scene: PackedScene
# Radius of the circle
@export var radius: float = 100.0

@export var rows: int = 50
# Width of each box
@export var box_width: float = 20.0

func _ready():
	var num_boxes = calculate_num_boxes(radius, box_width)
	spawn_boxes_in_circle(num_boxes)

func calculate_num_boxes(radius: float, box_width: float) -> int:
	# Calculate the circumference of the circle
	var circumference = 2 * PI * radius
	# Calculate the number of boxes needed
	return ceil(circumference / box_width)
	

func spawn_boxes_in_circle(num_boxes: int):
	
	for x in range(rows):
		radius += rows
		num_boxes = calculate_num_boxes(radius, box_width)
		for i in range(num_boxes):
			# Calculate the angle for this box (in radians)
			var angle = i * TAU / num_boxes
			
			# Calculate the position of the box
			var pos_x = radius * cos(angle)
			var pos_y = radius * sin(angle)
			var position = Vector2(pos_x, pos_y)
			
			# Instance the box scene
			var box = box_scene.instantiate()
			box.position = position
			
			# Rotate the box to face the center
			box.look_at(Vector2(0, 0))
			
			# Add the box as a child
			add_child(box)
		
		
		
