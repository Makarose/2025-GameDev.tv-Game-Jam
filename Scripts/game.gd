extends Node2D

enum States { MOVE, DAMAGE, DEATH }

@onready var camera_2d: Camera = $Camera2D
@onready var level_generator: Node2D = $LevelGenerator
@onready var player: Player = $Player


func _ready() -> void:
	camera_2d.setup_camera(player)
	level_generator.setup(player)
	
	SignalBus.player_damage.connect(_on_player_damage)
	SignalBus.game_over.connect(_on_game_over)


func _process(delta: float) -> void:
	pass


func _on_player_damage() -> void:
	player.state = States.DAMAGE


func _on_game_over() -> void:
	player.state = States.DEATH
