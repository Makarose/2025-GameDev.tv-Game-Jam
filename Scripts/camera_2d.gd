class_name Camera
extends Camera2D

var player: Player = null
var viewport_size: Vector2

@onready var kill_zone: Area2D = $KillZone
@onready var kill_zone_shape: CollisionShape2D = $KillZone/CollisionShape2D


func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	# initialize camera x position and limits
	global_position.x = viewport_size.x / 2
	limit_bottom = viewport_size.y
	limit_left = 0
	limit_right = viewport_size.x
	
	# Initialize KillZone position and collision shape size
	kill_zone.position.y = global_position.y + viewport_size.y
	kill_zone_shape.shape.size = Vector2(viewport_size.x, 200)


func _process(delta: float) -> void:
	# prevent camera from moving down to follow player
	if player:
		if limit_bottom > player.global_position.y + (viewport_size.y / 2):
			limit_bottom = player.global_position.y + (viewport_size.y / 2)


func _physics_process(delta: float) -> void:
	if player:
		global_position.y = player.global_position.y


func setup_camera(_player: Player) -> void:
	if _player:
		player = _player


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body is Platform:
		body.queue_free()
