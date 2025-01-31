extends CanvasLayer


@onready var texture_rect: TextureRect = $TextureRect
@onready var SFX_BUS_ID = db_to_linear(AudioServer.get_bus_index("SFX"))
@onready var MUSIC_BUS_ID =  db_to_linear(AudioServer.get_bus_index("Music"))
@onready var MASTER_BUS_ID =  db_to_linear(AudioServer.get_bus_index("Master"))
@onready var h_slider: HSlider = $Menu/HBoxContainer/VBoxContainer/HSlider
@onready var music_slider: HSlider = $Menu/HBoxContainer/VBoxContainer/musicSlider
@onready var sfx_slider: HSlider = $Menu/HBoxContainer/VBoxContainer/SFXSlider


@export var paused = false
@onready var settings: CanvasLayer = $"."

#func _ready():
	#sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(2))
	#music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(1))
	#h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if Input.is_action_just_pressed("Esc"):
		settings.visible = !settings.visible
		get_tree().paused = !get_tree().paused

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_fullscreen_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


#func _on_h_slider_changed(value):
	#AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	#

#func _on_music_slider_changed(value):
	#AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	

#func _on_sfx_slider_changed(value):
	#AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
	


func _on_sfx_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))


func _on_music_slider_value_changed(value: float):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))


#func _on_h_slider_value_changed(value: float):
	#AudioServer.set_bus_volume_db(MASTER_BUS_ID, linear_to_db(value))
