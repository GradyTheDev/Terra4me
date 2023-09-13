extends PanelContainer

signal natural_action_made(terra_packs_in_array: Array)

var terra_variables_res: Dictionary

func _on_button_up_with_stats(terra_packs_in_array):
	assert(terra_packs_in_array, "This pack is empty!")
	emit_signal("natural_action_made", terra_packs_in_array)
