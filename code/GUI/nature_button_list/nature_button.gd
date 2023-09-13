extends ButtonSound

signal button_up_with_stats(nature_terra_packs)

@export var nature_terra_pack: NatureTerraPack
var existing_species: int = 0:
	set(new):
		existing_species = new
		self.text = default_text + str("[x%d]" % existing_species)
@onready var default_text: String = self.text



func _init():
	self.button_up.connect(_on_button_up)
func _ready():
	existing_species = 0

func _process(_delta):
	var terra_variables_res = owner.terra_variables_res
	if terra_variables_res and nature_terra_pack:
		check_conditions(terra_variables_res)


func check_conditions(terra_variables_res):
	var are_conditions_fulfilled = true
	for key in terra_variables_res:
		var value = terra_variables_res[key].value
		var condition: Vector2 = nature_terra_pack.get_conditions()[key]
		if value < condition.x or value > condition.y:
			are_conditions_fulfilled = false
			break
	self.disabled = not are_conditions_fulfilled
	

func _on_button_up():
	existing_species += 1
	emit_signal("button_up_with_stats", nature_terra_pack.get_pack_terra_pack())
	await get_tree().create_timer(nature_terra_pack.duration_sec).timeout
	existing_species -= 1
