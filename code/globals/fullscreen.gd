extends Node

func _input(event):
	if event is InputEventKey:
		if not event.is_pressed():
			if event.keycode == KEY_F11:
				var m := DisplayServer.window_get_mode(0)
				if m == Window.MODE_FULLSCREEN:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED, 0)
				else:
					DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN, 0)