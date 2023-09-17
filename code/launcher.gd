extends CanvasLayer

func _input(event):
	if event is InputEventKey:
		if not event.is_pressed():
			if event.keycode != KEY_F11:
				_on_timer_timeout()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://code/menus/main/main_menu.tscn")
