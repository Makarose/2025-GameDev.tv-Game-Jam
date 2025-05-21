class_name Player
extends CharacterBody2D


enum States { MOVE, ATTACK, DEATH }

@export var state = States.MOVE

@export var max_speed := 120
@export var acceleration := 10000
@export var air_acceleration := 2000
@export var friction := 10000
@export var air_friction := 500
@export var up_gravity := 500
@export var down_gravity := 600
@export var jump_amount := 200
@export var bounce_amount := 600
@export var air_bounce_amount := 400

var viewport_size: Vector2
var coyote_time: float = 0.0
var previous_player_position: Vector2
var throw_animation_playing: bool = false

@onready var anchor: Node2D = $Anchor
@onready var projectile_spawn_point: Marker2D = $Anchor/ProjectileSpawnPoint
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var projectile = preload("res://Scenes/player_projectile.tscn")


func _ready() -> void:
	viewport_size = get_viewport_rect().size
	
	animation_player.animation_finished.connect(func(anim_name: String):
		_on_animation_finished(anim_name)
		)


func _process(delta: float) -> void:
	# Wrap character position
	if global_position.x <= -16:
		global_position.x = viewport_size.x + 16
	elif global_position.x >= viewport_size.x + 16:
		global_position.x = -16


func _physics_process(delta: float) -> void:
	coyote_time -= delta
	
	match state:
		States.MOVE:
			# Add the gravity.
			apply_gravity(delta)

			# Handle jump.
			if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote_time > 0):
				jump()

			# Get the input direction and handle the movement/deceleration.
			var direction: int = Input.get_axis("move_left", "move_right")
			if direction:
				accelerate_horizontally(direction, delta)
				anchor.scale.x = sign(direction) * -1
				if not throw_animation_playing:
					animation_player.play("walk")
			else:
				apply_friction(delta)
				if not throw_animation_playing:
					animation_player.play("idle")
				
			if not is_on_floor():
				if not throw_animation_playing:
					animation_player.play("jump")

			# For coyote jump
			var was_on_floor := is_on_floor()
			
			move_and_slide()
			
			# Add bounce when collide with RingBoundary
			var collision = get_last_slide_collision()
			if collision:
				var other_collider = collision.get_collider()
				if other_collider.name == "RingBoundary":
					var wall_normal = get_wall_normal()
					var bounce_force := bounce_amount
					if not is_on_floor():
						bounce_force = air_bounce_amount
					velocity = wall_normal * bounce_force
			
			# Handle projectile
			if Input.is_action_just_pressed("throw_projectile") and not throw_animation_playing:
				#state = States.ATTACK
				throw_projectile(anchor.scale.x)
				animation_player.play("throw")
				throw_animation_playing = true
			
			# Enable coyote jump
			if was_on_floor and not is_on_floor() and velocity.y >= 0:
				coyote_time = 0.1
			
		States.ATTACK:
			pass
			#if can_throw:
				#can_throw = false
				#throw_projectile(anchor.scale.x)
				#animation_player.play("throw")
				#
				#apply_gravity(delta)
				#apply_friction(delta)
				#
				#move_and_slide()
		
		States.DEATH:
			pass


func _on_animation_finished(anim_name: String) -> void:
	if anim_name == "throw":
		throw_animation_playing = false
		#state = States.MOVE


func throw_projectile(direction: int) -> void:
	var new_projectile = projectile.instantiate()
	new_projectile.global_position = projectile_spawn_point.global_position
	new_projectile.set_direction(sign(direction) * -1)
	get_tree().root.add_child(new_projectile)


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
