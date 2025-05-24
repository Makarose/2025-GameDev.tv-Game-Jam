extends Node2D

enum States { MOVE, DEATH }

@onready var camera_2d: Camera = $Camera2D
@onready var level_generator: Node2D = $LevelGenerator
@onready var player: Player = $Player


func _ready() -> void:
	camera_2d.setup_camera(player)
	level_generator.setup(player)
	
	SignalBus.game_over.connect(_on_game_over)


func _process(delta: float) -> void:
	pass


func _on_game_over() -> void:
	player.state = States.DEATH
