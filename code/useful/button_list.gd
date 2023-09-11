extends PanelContainer

signal natural_action_made(stats: TerraformingVaribles)



func _on_button_up_with_stats(stats):
	emit_signal("natural_action_made", stats)
