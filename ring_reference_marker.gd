extends Marker2D


var viewport_size: Vector2


func _ready() -> void:
	viewport_size = get_viewport_rect().size
	center_marker()


func _process(delta: float) -> void:
	pass


func center_marker() -> void:
	global_position = viewport_size / 2
