extends Resource
class_name TerraformingVaribles

@export var atmo := 0.0
@export var oxygen := 0.0
@export var heat := 0.0
@export var duration := 0.0

func get_terraforming_varibles() -> Dictionary:
	return {
		GlobalEnums.PLANET_MECHANIC.ATMO: atmo,
		GlobalEnums.PLANET_MECHANIC.OXYGEN: oxygen,
		GlobalEnums.PLANET_MECHANIC.HEAT: heat,
	}
