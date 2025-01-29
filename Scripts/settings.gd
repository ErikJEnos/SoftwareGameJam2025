extends CanvasLayer


@onready var texture_rect: TextureRect = $TextureRect
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")

@onready var menu: Control = %Menu
@export var paused = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("Esc"):
		menu.visible = !menu.visible
		get_tree().paused = !get_tree().paused
		#if paused == false:
			#pause()
			#
	#look up how to properly pause game when menu open
#func pause():
	#if paused:
		#Engine.time_scale = 1
	#else:
		#Engine.time_scale = 0
	#paused = !paused

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_button_pressed(): 
	texture_rect.visible = !texture_rect.visible

func _on_fullscreen_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_h_slider_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_volume_db(SFX_BUS_ID, value == 1)

func _on_music_slider_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, value == 1)


func _on_sfx_slider_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, value == 1)
