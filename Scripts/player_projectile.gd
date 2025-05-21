extends Node2D

@export var speed: float = 500.0
@export var rotation_speed: float = 10.0

var direction: int
var is_moving: bool = true

@onready var anchor: Node2D = $Anchor
@onready var banana_sprite: Sprite2D = $Anchor/BananaSprite
@onready var splat_sprite: Sprite2D = $Anchor/SplatSprite
@onready var hitbox: Area2D = $Hitbox


func _ready() -> void:
	anchor.scale.x = direction
	
	hitbox.hit_something.connect(func():
		is_moving = false
		banana_sprite.visible = false
		splat_sprite.visible = true
		await get_tree().create_timer(.1).timeout
		queue_free()
		)


func _process(delta: float) -> void:
	if is_moving:
		position.x += speed * direction * delta
		rotation += rotation_speed * direction * delta


func set_direction(_direction: int) -> void:
	if _direction:
		direction = _direction
