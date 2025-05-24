extends Area2D


@export var health: int = 3
@export var damage: int = 1
@export var move_speed: int = 40

@onready var left_ray_cast: RayCast2D = $LeftRayCast2D
@onready var right_ray_cast: RayCast2D = $RightRayCast2D


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if not left_ray_cast.is_colliding() or not right_ray_cast.is_colliding():
		move_speed = -move_speed
	position.x += move_speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage()
