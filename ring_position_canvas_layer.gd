extends CanvasLayer


@onready var ring_reference_marker: Marker2D = $RingReferenceMarker
@onready var ring_boundary: StaticBody2D = $"../RingBoundary"
@onready var camera_2d: Camera = $"../Camera2D"


# Update the position of the ring boundary relative to the Marker2D 
func _physics_process(delta: float) -> void:
	# Viewport coords of marker2D on CanvasLayer
	var marker_pos = ring_reference_marker.position
	# Canvas coords of marker2D
	var marker_canvas_layer_pos = (get_viewport().get_screen_transform() * get_viewport().get_canvas_transform()).affine_inverse() * marker_pos
	# Actual screen coords of marker2D
	var marker_screen_coord = get_viewport().get_screen_transform() * marker_canvas_layer_pos
	# Get camera center
	var camera_center = camera_2d.get_screen_center_position()
	# Calculate offset between marker screen y position and camera y position
	var camera_offset = marker_screen_coord.y - camera_center.y
	# Update ring boundary position to follow marker2D, correcting for camera movement
	ring_boundary.position = Vector2(marker_screen_coord.x, marker_screen_coord.y - camera_offset)
