extends Control

@export var start_scene: PackedScene



func _on_play_button_pressed() -> void:
	if start_scene:
		PlayerStats.score = 0
		get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
