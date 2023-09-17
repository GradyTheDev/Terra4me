extends Node

@export var levels: Array[PackedScene]
var levels_unlocked = 0


func unlock_next_level():
	levels_unlocked = max(levels_unlocked, levels.find(load(get_tree().current_scene.scene_file_path)) + 1)
	levels_unlocked = clamp(levels_unlocked, 0, len(levels)-1)

func get_least_level() -> PackedScene:
	return levels[levels_unlocked]
