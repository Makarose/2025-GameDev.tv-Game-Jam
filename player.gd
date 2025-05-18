class_name Player
extends CharacterBody2D


@export var max_speed := 120
@export var acceleration := 10000
@export var air_acceleration := 2000
@export var friction := 10000
@export var air_friction := 500
@export var up_gravity := 500
@export var down_gravity := 600
@export var jump_amount := 200
@export var bounce_amount := 400

var viewport_size: Vector2
var coyote_time: float = 0.0
var previous_player_position: Vector2

@onready var left_ray_cast: RayCast2D = $LeftRayCast
@onready var right_ray_cast: RayCast2D = $RightRayCast
@onready var up_ray_cast: RayCast2D = $UpRayCast
@onready var down_ray_cast: RayCast2D = $DownRayCast


func _ready() -> void:
	viewport_size = get_viewport_rect().size


func _process(delta: float) -> void:
	# wrap character position
	if global_position.x <= -16:
		global_position.x = viewport_size.x + 16
	elif global_position.x >= viewport_size.x + 16:
		global_position.x = -16
	
	# ring boundary
	if not left_ray_cast.is_colliding():
		global_position = previous_player_position
		velocity.x = bounce_amount
	elif not right_ray_cast.is_colliding():
		global_position = previous_player_position
		velocity.x = -bounce_amount
	elif not up_ray_cast.is_colliding():
		global_position = previous_player_position
		velocity.y = bounce_amount


func _physics_process(delta: float) -> void:
	coyote_time -= delta
	
	# Add the gravity.
	if not is_on_floor():
		apply_gravity(delta)

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_time > 0):
		jump()

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		accelerate_horizontally(direction, delta)
	else:
		apply_friction(delta)
	
	# coyote jump
	var was_on_floor := is_on_floor()
	
	previous_player_position = global_position
	
	move_and_slide()
	
	if was_on_floor and not is_on_floor() and velocity.y >= 0:
		coyote_time = 0.1


func jump() -> void:
	velocity.y = -jump_amount


func accelerate_horizontally(horizontal_direction: float, delta: float) -> void:
	var acceleration_amount := acceleration
	if not is_on_floor():
		acceleration_amount = air_acceleration
	velocity.x = move_toward(velocity.x, max_speed * horizontal_direction, acceleration_amount * delta)


func apply_friction(delta) -> void:
	var friction_amount := friction
	if not is_on_floor():
		friction_amount = air_friction
	velocity.x = move_toward(velocity.x, 0.0, friction_amount * delta)


func apply_gravity(delta) -> void:
	if not is_on_floor():
		if velocity.y <= 0:
			velocity.y += up_gravity * delta
		else:
			velocity.y += down_gravity * delta  
