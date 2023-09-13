extends ColorRect


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

func _on_value_changed(new_value: float):
	indicator.position.x = remap(new_value, min_value, max_value, 0, self.size.x) 
