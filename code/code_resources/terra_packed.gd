extends Resource
class_name TerraPack
# This pack is used for influencing Terraforming Varibles

@export var type: GlobalEnums.TERRA_VARIBLE_TYPE
@export var total_value: float = 0.0:
	set(new):
		total_value = new
		left_value = total_value
		calculate_per_sec()
@export var duration_sec: float = 0.0:
	set(new):
		duration_sec = new
		calculate_per_sec()
var left_value: float = NAN
var value_per_sec: float = NAN



func calculate_per_sec():
	if duration_sec == 0.0:
		value_per_sec = total_value
	value_per_sec = total_value / duration_sec
