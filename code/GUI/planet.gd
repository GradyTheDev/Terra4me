class_name Planet
extends PanelContainer

var atmosphere = preload("res://code/code_resources/terra_varible_resources/atmosphere.tres").duplicate(true)
var oxygen = preload("res://code/code_resources/terra_varible_resources/oxygen.tres").duplicate(true)
var heat = preload("res://code/code_resources/terra_varible_resources/heat.tres").duplicate(true)

var terraform_processes: Array

@onready var terra_varible_res = {
	GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE: atmosphere,
	GlobalEnums.TERRA_VARIBLE_TYPE.OXYGEN: oxygen,
	GlobalEnums.TERRA_VARIBLE_TYPE.HEAT: heat,
}



func _ready():
	$Indicators/Atmo.planet_mechanic_res = terra_varible_res[GlobalEnums.TERRA_VARIBLE_TYPE.ATMOSPHERE]
	$Indicators/Oxygen.planet_mechanic_res = oxygen
	$Indicators/Heat.planet_mechanic_res = heat

func _process(delta):
	do_constant_processes(delta)
	if terraform_processes:
		do_terraform_processes(delta)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().get_root().set_input_as_handled()
		GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.PAUSE)


func do_constant_processes(delta):
	heat.value += remap(atmosphere.value, 0, 100, -10, 10) * delta
	
	if atmosphere.value < 10:
		oxygen.value -= 5 * delta
	
	atmosphere.value -= 3 * delta


func do_terraform_processes(delta):
	var remove_terraform_processes: Array
	for terra_packed in terraform_processes:
		assert(terra_packed is TerraPack, "Bad packed placed!")
		terra_packed is TerraPack
		
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


func _on_spike_action_made(terra_pack: TerraPack):
	terraform_processes.append(terra_pack.duplicate(true))


func _on_natural_action_made(pack_terra_pack: PackTerraPack):
	for terra_pack in pack_terra_pack.array:
		terraform_processes.append(terra_pack.duplicate(true))
