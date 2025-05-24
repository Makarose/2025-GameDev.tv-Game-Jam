extends ParallaxLayer

@export var scrolling_speed := Vector2(40, 0)  # scroll right; use negative for left

func _process(delta: float) -> void:
	motion_offset += scrolling_speed * delta
