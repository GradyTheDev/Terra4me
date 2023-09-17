class_name NatureTerraPack
extends Resource

@export var name: String
@export var atmosphere_per_sec: float
@export var oxygen_per_sec: float
@export var heat_per_sec: float
@export var extinction_sec: float
@export_group("Conditions")
@export var atmosphere_condition: Vector2
@export var oxygen_condition: Vector2
@export var heat_condition: Vector2

var number_of_species: int = 0



func get_conditions() -> Dictionary:
	return {
		GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: atmosphere_condition,
		GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: oxygen_condition,
		GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: heat_condition,
	}

func get_nature_pack() -> Dictionary:
	return {
		GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: atmosphere_per_sec,
		GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: oxygen_per_sec,
		GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: heat_per_sec,
	}
