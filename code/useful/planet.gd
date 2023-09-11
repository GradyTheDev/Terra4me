class_name Planet
extends PanelContainer



@export var atmosphere: PlanetMechanic
@export var oxygen: PlanetMechanic
@export var heat: PlanetMechanic
@export var cooldown: float = 0
@export var duration: float = 0

var terraform_processes: Array = []

@onready var terraform_resources = {
	GlobalEnums.PLANET_MECHANIC.ATMO: atmosphere,
	GlobalEnums.PLANET_MECHANIC.OXYGEN: oxygen,
	GlobalEnums.PLANET_MECHANIC.HEAT: heat,
}



func _ready():
	atmosphere.value = 100
	$Indicators/Atmo.planet_mechanic_res = atmosphere
	$Indicators/Oxygen.planet_mechanic_res = oxygen
	$Indicators/Heat.planet_mechanic_res = heat

func _process(delta):
	if terraform_processes:
		do_terraform_processes(delta)

func _physics_process(delta: float):
	heat.value += remap(atmosphere.value, 0, 100, -10, 10) * delta
	
	if atmosphere.value < 10:
		oxygen.value -= 5 * delta
	
	atmosphere.value -= 3 * delta

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().get_root().set_input_as_handled()
		GlobalPopUps.call_scene(GlobalPopUps.SCENE.PAUSE)


func do_terraform_processes(delta):
	var remove_terraform_processes: Array
	for process in terraform_processes:
		var type = process.type
		var value_per_sec = process.value_per_sec
		var subtracted_value = value_per_sec * delta
		
		if sign(process.total) != sign(value_per_sec):
			subtracted_value = process.total
			process.total = 0.0
			remove_terraform_processes.append(process)
		else:
			process.total -= subtracted_value
		
		var terraform_res: PlanetMechanic = terraform_resources[type]
		terraform_res.value += subtracted_value
	
	for process in remove_terraform_processes:
		terraform_processes.erase(process)



func _on_button_list_natural_action_made(stats: TerraformingVaribles):
	var terraforming_varibles: Dictionary = stats.get_terraforming_varibles()
	for key in terraforming_varibles:
		if terraforming_varibles[key] == 0.0:
			continue
		var total_value = terraforming_varibles[key]
		terraform_processes.append({
			"type": key,
			"total": total_value,
			"value_per_sec": total_value/stats.duration
		})
