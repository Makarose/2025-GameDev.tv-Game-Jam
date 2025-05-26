class_name Projectile
extends Area2D


@export var projectile_count: int = 1
@export var sfx: String = "SingleBanana1"


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SfxManager.play_sfx(sfx)
		SignalBus.projectile_count += projectile_count
		queue_free()
