extends PanelContainer



func _on_start_button_up():
	pass # Replace with function body.


func _on_settings_button_up():
	SingletoneScenes.call_scene(SingletoneScenes.SCENE.SETTINGS)


func _on_credits_button_up():
	SingletoneScenes.call_scene(SingletoneScenes.SCENE.CREDITS)


func _on_exit_button_up():
	if OS.has_feature("web"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		get_tree().quit()