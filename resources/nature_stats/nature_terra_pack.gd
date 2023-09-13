class_name NatureTerraPack
extends Resource

@export var atmosphere: float = 0.0
@export var oxygen: float = 0.0
@export var heat: float = 0.0
@export var duration_sec: float = 0.0
@export_group("Conditions")
@export var atmosphere_condition: Vector2 = Vector2.ZERO
@export var oxygen_condition: Vector2 = Vector2.ZERO
@export var heat_condition: Vector2 = Vector2.ZERO

func get_conditions() -> Dictionary:
	return {
		GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: atmosphere_condition,
		GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: oxygen_condition,
		GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: heat_condition,
	}

func get_pack_terra_pack() -> Array:
	var translation_dict = {
		GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: atmosphere,
		GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: oxygen,
		GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: heat,
	}
	var pack_terra_pack: Array =[]
	for key in translation_dict:
		if translation_dict[key] == 0.0:
			continue
		var terra_pack = TerraPack.new()
		terra_pack.type = key
		terra_pack.total_value = translation_dict[key]
		terra_pack.duration_sec = duration_sec
		pack_terra_pack.append(terra_pack)
	assert(pack_terra_pack, "Pack is empty.")
	return pack_terra_pack
