extends Control



var master_bus = AudioServer.get_bus_index("Master")


func _on_toggle_sound_pressed() -> void:
	AudioServer.set_bus_mute(master_bus, not AudioServer.is_bus_mute(master_bus))



func _on_texture_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
	pass # Replace with function body.
	

func _on_texture_button_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.

func _on_texture_button_info_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/instructions.tscn")
	pass # Replace with function body.


func _on_texture_button_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
	pass # Replace with function body.
