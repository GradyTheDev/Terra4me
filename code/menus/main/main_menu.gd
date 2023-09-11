extends CanvasLayer



func _on_quit_pressed():
	if OS.has_feature("web"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		get_tree().quit()


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://code/levels/level_3/level_3.tscn")


func _on_credits_pressed():
	GlobalPopUps.call_scene(GlobalPopUps.SCENE.CREDITS)


func _on_settings_pressed():
	GlobalPopUps.call_scene(GlobalPopUps.SCENE.SETTINGS)
