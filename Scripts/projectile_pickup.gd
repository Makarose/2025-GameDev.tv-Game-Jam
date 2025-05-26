class_name Projectile
extends Area2D


@export var projectile_count: int = 1


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SfxManager.play_sfx("SingleBanana1")
		SignalBus.projectile_count += projectile_count
		queue_free()
