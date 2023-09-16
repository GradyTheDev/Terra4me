extends CanvasLayer

@onready var levels_buttons = {
	0: [$Level_1],
	1: [$Level_2],
	2: [$Level_3],
	3: [$Level_4_1,$Level_4_2],
}

func _ready():
	for unlocked_index in range(0, LevelUnlocker.levels_unlocked + 1):
		for level_button in levels_buttons[unlocked_index]:
			level_button.disabled = false



func _on_level_1_button_up():
	get_tree().change_scene_to_file("res://code/levels/level_1/level_1.tscn")

func _on_level_2_button_up():
	get_tree().change_scene_to_file("res://code/levels/level_2/level_2.tscn")

func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://code/levels/level_3/level_3.tscn")

func _on_level_4_button_up():
	get_tree().change_scene_to_file("res://code/levels/level_4/level_4.tscn")


func _on_credits_pressed():
	GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.CREDITS)


func _on_settings_pressed():
	GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.SETTINGS)


func _on_quit_pressed():
	if OS.has_feature("web"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		get_tree().quit()
