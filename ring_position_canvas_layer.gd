extends CanvasLayer

@onready var ring_reference_marker: Marker2D = $RingReferenceMarker
@onready var ring_boundary: StaticBody2D = $"../RingBoundary"

@onready var test_sprite_2d: Sprite2D = $"../TestSprite2D"
@onready var camera_2d: Camera = $"../Camera2D"


func _ready() -> void:
	pass


# Update the position of the collision shape relative to the Marker2D 
func _process(delta: float) -> void:
	#pass
	var marker_pos = ring_reference_marker.position
	#print("Marker screen pos: " + str(ring_reference_marker.position))
	var canvas_layer_pos = (get_viewport().get_screen_transform() * get_viewport().get_canvas_transform()).affine_inverse() * marker_pos
	#print("Marker canvas layer pos: " + str(canvas_layer_pos))
	#var screen_coord =  get_viewport().get_screen_transform() * get_viewport().get_canvas_transform() * canvas_layer_pos
	var screen_coord = get_viewport().get_screen_transform() * canvas_layer_pos
	var camera_center = camera_2d.get_screen_center_position()
	var camera_offset = screen_coord.y - camera_center.y
	print("Marker transform screen pos: " + str(screen_coord))
	print("Camera Center Pos: " + str(camera_center))
	print("Camera Offset: " + str(camera_offset))
	test_sprite_2d.position = Vector2(screen_coord.x, screen_coord.y - camera_offset)
	#ring_boundary.position = screen_coord
	
	#var marker_screen_pos = ring_reference_marker.position
	#print("Screen Pos: " + str(marker_screen_pos))
	#var marker_canvas_pos = get_viewport().get_screen_transform() * get_viewport().get_canvas_transform().affine_inverse() * marker_screen_pos
	#print("Marker Canvas Pos: " + str(marker_canvas_pos))
	#ring_boundary.position = marker_canvas_pos
	
	#var marker_screen_pos: Vector2 = ring_reference_marker.position
	#var canvas_transform: Transform2D = get_final_transform()
	#var viewport_coords: Vector2 = canvas_transform.basis_xform(marker_screen_pos)
	#print("Marker Global Position: " + str(marker_screen_pos))
	#print("Canvas Transform: " + str(canvas_transform))
	#print("Viewport Coords: " + str(viewport_coords))
