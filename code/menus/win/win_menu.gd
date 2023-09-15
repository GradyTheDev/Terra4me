extends PanelContainer

func _enter_tree():
	get_tree().paused = true

func _exit_tree():
	get_tree().paused = false


func close_window():
	get_parent().remove_child(self)


func _on_next_button_up():
	get_tree().change_scene_to_packed(LevelUnlocker.get_least_level())
	close_window()


func _on_back_button_up():
	close_window()


func _on_settings_button_up():
	GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.SETTINGS)


func _on_main_menu_button_up():
	get_tree().change_scene_to_file("res://code/menus/main/main_menu.tscn")
	close_window()


