extends CanvasLayer


func _ready() -> void:
	visible = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		toggle_pause()
	elif Input.is_action_just_pressed("Quit"):
		get_tree().quit()


func toggle_pause() -> void:
	get_tree().paused = !get_tree().paused
	visible = !visible
