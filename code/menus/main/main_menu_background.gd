extends Node2D

var tween_planet_pair: Dictionary
@onready var planet_indexes = {
	0: [$Orbits/CenterPlanet0],
	1: [$Orbits/CenterPlanet1],
	2: [$Orbits/CenterPlanet2],
	3: [$Orbits/CenterPlanet3_1, $Orbits/CenterPlanet3_2],
}
var tween_array: Array

func _ready():
	for planet_arr in planet_indexes.values():
		for planet in planet_arr:
			var tween: Tween = get_tree().create_tween().set_loops()
			tween.bind_node(planet)
			start_animation(planet, tween)
	

func _on_select_animation(is_active, planet_index: int):
	var selected_planet = planet_indexes[planet_index]
	for planet in selected_planet:
		if is_active:
			planet.scale *= 1.5
		else:
			planet.scale = Vector2.ONE

func start_animation(planet: Node2D, tween: Tween):
	tween.tween_property(planet, "rotation", 0.25, 0.5)
	tween.tween_property(planet, "rotation", -0.25, 1)
	tween.tween_property(planet, "rotation", 0, 0.5)



func _on_level_3_hover_changed(is_hoverd, extra_arg_0):
	pass # Replace with function body.
