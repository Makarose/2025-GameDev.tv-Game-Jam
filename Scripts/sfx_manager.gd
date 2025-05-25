extends Node

func _ready():
	print("SfxManager ready")
	play_sfx("Jump")
	
# Plays a sound effect by the node name (must match one of the children)
func play_sfx(name: String):
	var sfx_node = get_node_or_null(name)
	print("Children of SfxManager:")
	
	for child in get_children():
		print(child.name)
	if sfx_node and sfx_node is AudioStreamPlayer2D:
		sfx_node.play()
	else:
		print("Sound effect not found: ", name)
