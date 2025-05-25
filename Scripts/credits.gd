extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_page.tscn")
	pass # Replace with function body.


func _on_texture_button_next_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits_2.tscn")
	pass # Replace with function body.
