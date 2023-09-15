extends Control

@export var number_of_planets_to_win = 1

func _on_planet_planet_compleated():
	number_of_planets_to_win -= 1
	if number_of_planets_to_win <= 0:
		LevelUnlocker.unlock_next_level()
		GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.WIN_TSCN)
