extends Control
@onready var menu: Control = %Menu



func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/settings.tscn")
	

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Prefabs/animation_scene.tscn")
