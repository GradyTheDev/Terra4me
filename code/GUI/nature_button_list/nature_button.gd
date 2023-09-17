extends ButtonSound

signal button_up_with_stats(nature_terra_packs)

@export var nature_terra_pack: NatureTerraPack
var existing_species: int = 0:
	set(new):
		existing_species = new
		nature_terra_pack.number_of_species = new
		self.text = default_text + str("[x%d]" % existing_species)
@onready var default_text: String = self.text
var extinciton_timer = Timer.new()


func _init():
	self.button_up.connect(_on_button_up)
	extinciton_timer.timeout.connect(_on_extinction_timer_timeout)

func _ready():
	if not nature_terra_pack:
		return
	self.add_child(extinciton_timer)
	emit_signal("button_up_with_stats", nature_terra_pack)
	existing_species = 0
	set_hint()

func _process(_delta):
	if owner == null:
		return
	var terra_variables_res = owner.terra_variables_res
	if terra_variables_res and nature_terra_pack:
		check_conditions(terra_variables_res)

func set_hint():
	self.tooltip_text = """
	Atmosphere: %s
	Oxygen: %s
	Heat: %s
	""" % [nature_terra_pack.atmosphere_per_sec, 
			nature_terra_pack.oxygen_per_sec, 
			nature_terra_pack.heat_per_sec,]

func check_conditions(terra_variables_res):
	var are_conditions_fulfilled = true
	for key in terra_variables_res:
		var value = terra_variables_res[key].value
		var condition: Vector2 = nature_terra_pack.get_conditions()[key]
		if value < condition.x or value > condition.y:
			are_conditions_fulfilled = false
			if existing_species > 0 and extinciton_timer.is_stopped():
				extinciton_timer.start(nature_terra_pack.extinction_sec)
			break
	self.disabled = not are_conditions_fulfilled
	if existing_species == 0:
		extinciton_timer.stop()
	if not extinciton_timer.is_stopped() and are_conditions_fulfilled:
		extinciton_timer.stop()


func _on_button_up():
	existing_species += 1


func _on_extinction_timer_timeout():
	existing_species -= 1
	if existing_species < 0:
		existing_species = 0
	self.text = default_text + str("[x%d]" % existing_species)
