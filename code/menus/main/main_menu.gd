extends CanvasLayer



func _on_start_button_up():
	pass # Replace with function body.


func _on_settings_button_up():
	GlobalPopUps.call_scene(GlobalPopUps.SCENE.SETTINGS)


func _on_credits_button_up():
	GlobalPopUps.call_scene(GlobalPopUps.SCENE.CREDITS)


func _on_exit_button_up():
	if OS.has_feature("web"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		get_tree().quit()


func _on_quit_pressed():
	get_tree().quit()


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://code/levels/level_3/level_3.tscn")
