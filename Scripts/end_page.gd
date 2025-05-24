extends Control


@onready var this_height: Label = $MarginContainer/VBoxContainer/ThisHeight
@onready var best_height: Label = $MarginContainer/VBoxContainer/BestHeight


func _ready() -> void:
	this_height.text = "Height Reached = " + str(SignalBus.distance_climbed) + "'"
	best_height.text = "Best Height Ever = " + str(SignalBus.best_distance) + "'"


func _on_texture_button_replay_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_texture_button_quit_pressed() -> void:
	get_tree().quit()
