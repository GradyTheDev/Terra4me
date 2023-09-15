extends Node

@export var levels: Array[PackedScene]
var levels_unlocked = 0


func unlock_next_level():
	levels_unlocked += 1

func get_least_level() -> PackedScene:
	return levels[levels_unlocked]
