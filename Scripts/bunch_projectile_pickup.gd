extends Area2D


@export var speed: float = 500.0
@export var projectile_count: int = 3
@export var sfx: String = "BunchBanana2"


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	position.y += speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SfxManager.play_sfx(sfx)
		SignalBus.projectile_count += projectile_count
		queue_free()
