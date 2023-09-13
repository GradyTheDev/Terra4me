extends PanelContainer

signal natural_action_made(pack_terra_pack: PackTerraPack)



func _on_button_up_with_stats(pack_terra_pack):
	assert(pack_terra_pack, "This pack is empty!")
	emit_signal("natural_action_made", pack_terra_pack)
