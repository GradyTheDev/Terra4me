extends PanelContainer

signal natural_action_made(nature_terra_pack: NatureTerraPack)

var terra_variables_res: Dictionary

func _on_button_up_with_stats(nature_terra_pack: NatureTerraPack):
	assert(nature_terra_pack, "This pack is empty!")
	emit_signal("natural_action_made", nature_terra_pack)
