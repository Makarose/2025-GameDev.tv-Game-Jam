extends Node2D


@onready var camera_2d: Camera = $"../Camera2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#print("Viewport Rect: " + str(get_viewport_rect().size))
	#print("Camera Center Pos: " + str(camera_2d.get_screen_center_position()))
