class_name PlanetMechanic
extends Resource

signal value_changed(value)

@export var display_name: String = "Mechanic's Name"
@export var max_value: float = 100.0
@export var min_value: float = 0.0
@export var value: float:
	set(new):
		value = clamp(new, min_value, max_value)
		emit_signal("value_changed", value)
