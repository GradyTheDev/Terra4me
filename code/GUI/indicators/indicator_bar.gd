extends PanelContainer

signal spike_action_made(terra_packed)

const DISPLAY_NAME = {
	GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: "Atmosphere",
	GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: "Oxygen",
	GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: "Heat",
}


@export var is_debug := true:
	set(new):
		is_debug = new
		if is_debug:
			print_debug("Runned with debug mode:")
			planet_mechanic_res = load("res://code/planet_mechanic/mock.tres")

var planet_mechanic_res: TerraVaribleRes:
	set(new):
		planet_mechanic_res = new
		if not self.is_inside_tree():
			await(self.ready)
		$Background.planet_mechanic_res = planet_mechanic_res
		$Title.text = DISPLAY_NAME[planet_mechanic_res.type]

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
		print_debug("Runned with debug mode:")
		planet_mechanic_res = load("res://code/code_resources/terra_varible_resources/mock.tres")
	cooldown_progress.max_value = cooldown_sec


func _process(delta):
	if not cooldown_timer.is_stopped():
		cooldown_progress.value = cooldown_timer.time_left


func create_terraforming_varibles(is_total_value_positive: bool):
	assert(planet_mechanic_res, "Resource need to be assigned first!")
	start_cooldown()
	var terra_packed = TerraPack.new()
	terra_packed.type = planet_mechanic_res.type
	if is_total_value_positive:
		terra_packed.total_value = total_value
	else:
		terra_packed.total_value = total_value * -1
	terra_packed.duration_sec = duration_sec
	emit_signal("spike_action_made", terra_packed)


func start_cooldown():
	$Increase.disabled = true
	$Decrease.disabled = true
	cooldown_timer.start(cooldown_sec)

func _on_cooldown_timeout():
	$Increase.disabled = false
	$Decrease.disabled = false


func _on_increase_button_down():
	create_terraforming_varibles(true)


func _on_decrease_button_down():
	create_terraforming_varibles(false)
