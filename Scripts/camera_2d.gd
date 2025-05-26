class_name Camera
extends Camera2D

@export_range (0, 1) var decay: float = 0.8 #How quickly shaking will stop [0,1].
@export var max_offset: Vector2 = Vector2(100,75) #Maximum displacement in pixels.
@export var max_roll = 0.0 #Maximum rotation in radians (use sparingly).
@export var noise : FastNoiseLite #The source of random values.

var noise_y = 0 #Value used to move through the noise
var trauma: float = 0.0 #Current shake strength
var trauma_pwr: int = 3 #Trauma exponent. Use [2,3]

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
	kill_zone.global_position.y = get_screen_center_position().y + viewport_size.y / 2 + 250
	kill_zone_shape.shape.size = Vector2(viewport_size.x, 200)
	
	# For camera shake:
	randomize()
	noise.seed = randi()


func _process(delta: float) -> void:
	# prevent camera from moving down to follow player
	if player:
		if limit_bottom > player.global_position.y + (viewport_size.y / 2):
			limit_bottom = player.global_position.y + (viewport_size.y / 2)
			
	# Camera shake
	if (trauma):
		trauma = max(trauma - decay * delta, 0)
		shake()
	elif (offset.x != 0 or offset.y != 0 or rotation != 0):
		lerp(offset.x,0.0,1)
		lerp(offset.y,0.0,1)
		lerp(rotation,0.0,1)


func _physics_process(delta: float) -> void:
	if player:
		global_position.y = player.global_position.y


func add_trauma(amount: float):
	trauma = min(trauma + amount, 1.0)


func shake():
	var amt = pow(trauma, trauma_pwr)
	noise_y += 1
	rotation = max_roll * amt * noise.get_noise_2d(noise.seed,noise_y)
	offset.x = max_offset.x * amt * noise.get_noise_2d(noise.seed*2,noise_y)
	offset.y = max_offset.y * amt * noise.get_noise_2d(noise.seed*3,noise_y)


func setup_camera(_player: Player) -> void:
	if _player:
		player = _player


func _on_kill_zone_body_entered(body: Node2D) -> void:
	if body is Platform:
		body.queue_free()
