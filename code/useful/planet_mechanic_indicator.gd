extends PanelContainer

@export var is_debug := false
var planet_mechanic_res: PlanetMechanic:
	set(new):
		planet_mechanic_res = new
		max_value = planet_mechanic_res.max_value
		min_value = planet_mechanic_res.min_value
		planet_mechanic_res.value_changed.connect(_on_value_changed)
		if not self.is_inside_tree():
			await(self.ready)
		$Title.text = planet_mechanic_res.display_name
		_on_value_changed(planet_mechanic_res.value)
var max_value: float
var min_value: float

@export_group("Buttons")
@export var total_value = 30
@export var duration_sec = 10
@export var cooldown_sec = 30

# From Vector2.x to Vector2.y
@export var orange_range: Vector2:
	set(new):
		orange_range = new
		$Background/OrangeArea.position.x = remap(orange_range.x, 0, 100, 0, $Background.size.x)
		$Background/OrangeArea.size.x = remap(orange_range.x - orange_range.y, 0, 100, 0, $Background.size.x)
@export var green_range: Vector2:
	set(new):
		green_range = new
		$Background/GreenArea.position.x = remap(green_range.x, 0, 100, 0, $Background.size.x)
		$Background/GreenArea.size.x = remap(green_range.y - green_range.x, 0, 100, 0, $Background.size.x)

var value_per_sec: float

@onready var cooldown_timer = $Cooldown
@onready var duration_timer = $Duration
@onready var cooldown_progress = $CooldownProgress
@onready var indicator = $Background/Indicator


func _ready():
	if is_debug:
		planet_mechanic_res = load("res://code/planet_mechanic/mock.tres")
	cooldown_progress.max_value = cooldown_sec


func _process(delta):
	if not duration_timer.is_stopped():
		planet_mechanic_res.value += value_per_sec * delta
	if not cooldown_timer.is_stopped():
		cooldown_progress.value = cooldown_timer.time_left

func _on_value_changed(new_value: float):
	if is_instance_valid(indicator):
		indicator.position.x = remap(new_value, min_value, max_value, 0, $Background.size.x) 



func change_value_from_button(_total_value: float):
	value_per_sec = _total_value / duration_sec
	assert(cooldown_timer.is_stopped(), "Button should be disabled on cooldown!")
	$Increase.disabled = true
	$Decrease.disabled = true
	cooldown_timer.start(cooldown_sec)
	duration_timer.start(duration_sec)
	


func _on_increase_button_down():
	change_value_from_button(total_value)


func _on_decrease_button_down():
	change_value_from_button(total_value * -1)


func _on_cooldown_timeout():
	$Increase.disabled = false
	$Decrease.disabled = false
