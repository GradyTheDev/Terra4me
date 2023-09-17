class_name Planet
extends Control

signal planet_compleated()

@export var planet_name: String
@export var job_text: String
@export var map: Texture

@export_group('victory conditions')
@export var atmosphere_ranges: Array[RangeResource]
@export var oxygen_ranges: Array[RangeResource]
@export var heat_ranges: Array[RangeResource]
@export var sec_to_win: float = 5

@export_group("nodes")
@export var dialog_system: DialogSystem

@export_group("dialog")
@export var dialog_intro: Dialog
@export var dialog_win: Dialog
@export var dialog_lose: Dialog
@export var dialog_random: Array[Dialog]


var atmosphere = preload("res://resources/terra_varible_resources/atmosphere.tres").duplicate(true)
var oxygen = preload("res://resources/terra_varible_resources/oxygen.tres").duplicate(true)
var heat = preload("res://resources/terra_varible_resources/heat.tres").duplicate(true)
var terraform_processes: Array
var pack_of_nature: Array[NatureTerraPack]
var win_ranges: Dictionary 

@export_group("Random")
@export var rnd_min: float
@export var rnd_max: float
var _rnd_timer: float = 15

@onready var terra_varible_res = {
	GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: atmosphere,
	GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: oxygen,
	GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: heat,
}
@onready var terra_varible_ranges_res = {
	GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: atmosphere_ranges,
	GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: oxygen_ranges,
	GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: heat_ranges,
}
@onready var win_timer = $WinTimer


func _ready():
	$Indicators/Atmo.planet_mechanic_res = atmosphere
	$Indicators/Atmo.ranges = atmosphere_ranges
	$Indicators/Oxygen.planet_mechanic_res = oxygen
	$Indicators/Oxygen.ranges = oxygen_ranges
	$Indicators/Heat.planet_mechanic_res = heat
	$Indicators/Heat.ranges = heat_ranges
	$ButtonList.terra_variables_res = terra_varible_res
	add_ranges_to_win_ranges()
	if map:
		$Map.texture = map

	dialog_system.play_dialog(dialog_intro)

	$TopInformation/Title.text = planet_name
	$TopInformation/Task.text = job_text

func _process(delta):
	if dialog_system._current_msg == null and len(dialog_random) > 0:
		_rnd_timer -= delta

		if _rnd_timer <= 0:
			_rnd_timer = randf_range(rnd_min, rnd_max)
			dialog_system.play_dialog(dialog_random[randi_range(0, len(dialog_random)-1)])


	do_constant_processes(delta)
	if terraform_processes:
		do_terraform_processes(delta)
	if win_ranges:
		var fulfill_ranges = true
		for key in win_ranges:
			var result = is_in_range(terra_varible_res[key].value, win_ranges[key].range)
			if result == false:
				fulfill_ranges = false
				if not win_timer.is_stopped():
					win_timer.stop()
				break
		if fulfill_ranges and win_timer.is_stopped():
			win_timer.start(sec_to_win)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().get_root().set_input_as_handled()
		GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.PAUSE)
	if OS.is_debug_build():
		if event is InputEventKey:
			if event.keycode == KEY_F4:
				_on_win_timer_timeout()

func do_constant_processes(delta):
	if pack_of_nature:
		for nature_terra_pack in pack_of_nature:
			var nature_per_sec_dict = nature_terra_pack.get_nature_pack()
			for key in nature_per_sec_dict:
				var total_terra_var_per_sec = nature_per_sec_dict[key] * nature_terra_pack.number_of_species
				terra_varible_res[key].value += total_terra_var_per_sec * delta


func do_terraform_processes(delta):
	var remove_terraform_processes: Array = []
	for terra_packed in terraform_processes:
		assert(terra_packed is TerraPack, "Bad packed placed!")
		
		var value_per_sec = terra_packed.value_per_sec
		var subtracted_value = value_per_sec * delta
		
		if sign(terra_packed.left_value) != sign(value_per_sec):
			subtracted_value = terra_packed.left_value
			terra_packed.left_value = 0.0
			remove_terraform_processes.append(terra_packed)
		else:
			terra_packed.left_value -= subtracted_value
		
		var terraform_res: TerraVaribleRes = terra_varible_res[terra_packed.type]
		terraform_res.value += subtracted_value
	
	for process in remove_terraform_processes:
		terraform_processes.erase(process)

func add_ranges_to_win_ranges():
	for key in terra_varible_ranges_res:
		for ranges_res in terra_varible_ranges_res[key]:
			if ranges_res.color == GlobalEnums.IndicatorRangeColor.GREEN:
				win_ranges[key] = ranges_res


func is_in_range(value: float, condition: Vector2) -> bool:
	if value < condition.x or value > condition.y:
		return false
	return true

func _on_spike_action_made(terra_pack: TerraPack):
	terraform_processes.append(terra_pack.duplicate(true))


func _on_natural_action_made(nature_terra_pack: NatureTerraPack):
	pack_of_nature.append(nature_terra_pack)


func _on_win_timer_timeout():
	dialog_system.play_dialog(dialog_win)
	emit_signal("planet_compleated")
	self.process_mode = Node.PROCESS_MODE_DISABLED
