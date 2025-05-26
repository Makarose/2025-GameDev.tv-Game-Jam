extends Node


@export var sfx_volume: float = -5.0


func _ready() -> void:
	for child in get_children():
		if child is AudioStreamPlayer:
			child.volume_db = sfx_volume


# Plays a sound effect by the node name (must match one of the children)
func play_sfx(name: String):
	var sfx_node = get_node_or_null(name)
	if sfx_node and sfx_node is AudioStreamPlayer:
		sfx_node.play()
	else:
		print("Sound effect not found: ", name)
