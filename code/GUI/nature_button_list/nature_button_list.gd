extends Control

signal natural_action_made(nature_terra_pack: NatureTerraPack)

@export var nature_actions: Array[NatureTerraPack]

var terra_variables_res: Dictionary



func _on_button_up_with_stats(nature_terra_pack: NatureTerraPack):
	assert(nature_terra_pack, "This pack is empty!")
	emit_signal("natural_action_made", nature_terra_pack)


func _ready():
	var b = $VBoxContainer/tmp as ButtonSound

	for x in nature_actions:
		var c = b.duplicate()
		c.nature_terra_pack = x.duplicate(true)
		c.text = x.name
		c.process_mode = Node.PROCESS_MODE_INHERIT
		$VBoxContainer.add_child(c)
	
	b.queue_free()
