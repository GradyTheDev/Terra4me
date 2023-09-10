class_name Planet
extends Node

@export_range(0,100) var heat: float : 
	set(value):
		heat = clamp(value, 0, 100)

@export_range(0,100) var oxygen: float :
	set(value):
		oxygen = clamp(value, 0, 100)

@export_range(0,100) var atmosphere: float :
	set(value):
		atmosphere = clamp(value, 0, 100)


func _physics_process(delta: float):
	heat += remap(atmosphere, 0, 100, -10, 10) * delta
	
	if atmosphere < 10:
		oxygen -= 5 * delta
	
	atmosphere -= 3 * delta