extends CanvasLayer

const POP_UP = GlobalEnums.POP_UP

var SETTINGS_TSCN: PackedScene = load("res://code/menus/settings/settings.tscn")
var CREDITS_TSCN: PackedScene = load("res://code/menus/credits/credits.tscn")
var PAUSE_TSCN: PackedScene = load("res://code/menus/pause/pause_menu.tscn")

var scenes_dict = {
	POP_UP.SETTINGS: SETTINGS_TSCN.instantiate(),
	POP_UP.CREDITS: CREDITS_TSCN.instantiate(),
	POP_UP.PAUSE: PAUSE_TSCN.instantiate(),
}


func _init():
	assert(POP_UP.size() == scenes_dict.size(), "PopUp scenes aren't equal")
	for key in scenes_dict:
		assert(scenes_dict[key] != null, "Popup Scene failed to load!")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		self.remove_child(self.get_child(-1))

func call_scene(pop_up: POP_UP):
	var scene_inst = scenes_dict[pop_up]
	if scene_inst.is_inside_tree():
		self.move_child(scene_inst, -1)
	else:
		self.add_child(scenes_dict[pop_up])
