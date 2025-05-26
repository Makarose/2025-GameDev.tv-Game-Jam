extends Area2D

@export var speed: float = 350.0

var is_moving: bool = true

@onready var orange_sprite: Sprite2D = $OrangeSprite
@onready var splat_sprite: Sprite2D = $SplatSprite


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	if is_moving:
		position.y += speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.take_damage()
		is_moving = false
		orange_sprite.visible = false
		splat_sprite.visible = true
		await get_tree().create_timer(.1).timeout
		queue_free()
