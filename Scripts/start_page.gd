extends Control

@export var normal_off: Texture
@export var hover_off: Texture
@export var normal_on: Texture
@export var hover_on: Texture

var master_bus = AudioServer.get_bus_index("Master")
var button: TextureButton

func _ready():
	button = $"ToggleSound"
	button.toggle_mode = true
	button.texture_normal = normal_off
	button.texture_pressed = normal_on
	button.connect("pressed", Callable(self, "_on_toggle_sound_pressed"))
	button.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	button.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

func _on_toggle_sound_pressed() -> void:
	AudioServer.set_bus_mute(master_bus, not AudioServer.is_bus_mute(master_bus))
	if button.get_rect().has_point(button.get_local_mouse_position()):
		_on_toggle_sound_mouse_entered()
	else:
		_on_toggle_sound_mouse_entered()
	pass # Replace with function body.

func _on_toggle_sound_mouse_entered() -> void:
	if button.pressed:
		button.texture_normal = hover_on
	else:
		button.texture_normal = hover_off
	pass # Replace with function body.

func _on_toggle_sound_mouse_exited() -> void:
	if button.pressed:
		button.texture_normal = normal_on
	else:
		button.texture_normal = normal_off
	pass # Replace with function body.
	


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
