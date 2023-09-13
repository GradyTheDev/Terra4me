class_name TerraVaribleRes
extends Resource

signal value_changed(value)

@export var type: GlobalEnums.TERRA_VARIBLE_TYPE
@export var min_value: float = 0.0
@export var max_value: float = 100.0
@export var value: float:
	set(new):
		value = clamp(new, min_value, max_value)
		emit_signal("value_changed", value)
