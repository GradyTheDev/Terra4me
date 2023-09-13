extends Control

const RANGE_AREA_TSCN = preload("res://code/GUI/indicators/range_area.tscn")

var planet_mechanic_res: TerraVaribleRes:
	set(new):
		planet_mechanic_res = new
		max_value = planet_mechanic_res.max_value
		min_value = planet_mechanic_res.min_value
		planet_mechanic_res.value_changed.connect(_on_value_changed)
		_on_value_changed(planet_mechanic_res.value)


var max_value: float
var min_value: float
@onready var indicator = $Indicator

func add_range(range_res: RangeResource):
	var range = range_res.range
	var range_inst = RANGE_AREA_TSCN.instantiate()
	range_inst.indicator_color = range_res.color
	range_inst.position.x = remap(range.x, 0, 100, 0, self.size.x)
	range_inst.size.x = remap(range.y - range.x, 0, 100, 0, self.size.x)
	range_inst.size.y = self.size.y
	self.add_child(range_inst)

func _on_value_changed(new_value: float):
	indicator.position.x = remap(new_value, min_value, max_value, 0, self.size.x) 
