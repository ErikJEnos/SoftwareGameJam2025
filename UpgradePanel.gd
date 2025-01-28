extends Panel

var images = [
	preload("res://Images/bounce up.png"),
	preload("res://Images/bullet count up.png"),
	preload("res://Images/attack_up.png"),
	preload("res://Images/fire rate.png"),
	preload("res://Images/bullet_speed_up.png"),
]

var imagesReady = []
var buttons = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SetUpPanel()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func pick_random_images(count: int) -> Array:
	var randomImages = images.duplicate()
	randomImages.shuffle() 
	return randomImages.slice(0, count)  
	
func SetUpPanel():
	imagesReady = pick_random_images(3)
	
	buttons = find_children("Button")
	
	for i in range(imagesReady.size()):
		print(imagesReady[i].get_image())
		buttons[i].icon = imagesReady[i]

func CheckUpgrade(index: int = 0):
	for x in range(images.size()):
		if(buttons[index].icon == images[x]):
			GivePlayerUpgrade(x)

func GivePlayerUpgrade(index: int = 0):
	var player = get_node("/root/GameNode/Player")
	match index:
			0:
				player.get_node("CharacterBody2D").BounceUp()
			1:
				player.get_node("CharacterBody2D").BulletCountUp()
			2:
				player.get_node("CharacterBody2D").DamageUp()
			3:
				player.get_node("CharacterBody2D").FireRateUp()
			4:
				player.get_node("CharacterBody2D").BulletSpeedUp()
			_:
				print("No matching case for index:", index)
	SetUpPanel()
	visible = false
	pass

func _on_button1_pressed() -> void:
	CheckUpgrade(0)
	pass # Replace with function body.


func _on_button2_pressed() -> void:
	CheckUpgrade(1)
	pass # Replace with function body.


func _on_button3_pressed() -> void:
	CheckUpgrade(2)
	pass # Replace with function body.
