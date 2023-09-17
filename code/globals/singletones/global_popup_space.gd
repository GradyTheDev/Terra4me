extends CanvasLayer

const POP_UP = GlobalEnums.POP_UP

var SETTINGS_TSCN: PackedScene = load("res://code/menus/settings/settings.tscn")
var CREDITS_TSCN: PackedScene = load("res://code/menus/credits/credits.tscn")
var PAUSE_TSCN: PackedScene = load("res://code/menus/pause/pause_menu.tscn")
var WIN_TSCN: PackedScene = load("res://code/menus/win/win_menu.tscn")

var scenes_dict = {
	POP_UP.SETTINGS: SETTINGS_TSCN.instantiate(),
	POP_UP.CREDITS: CREDITS_TSCN.instantiate(),
	POP_UP.PAUSE: PAUSE_TSCN.instantiate(),
	POP_UP.WIN_TSCN: WIN_TSCN.instantiate(),
}


# This is to remove background for Tooltips
func _enter_tree() -> void:
	get_tree().node_added.connect(on_node_added)

func on_node_added(node: Node) -> void:
	var pp := node as PopupPanel
	if pp and pp.theme_type_variation == "TooltipPanel":
		pp.transparent_bg = true
		#pp.canvas_transform = pp.canvas_transform.scaled(Vector2(0.1, 0.1))



func _init():
	assert(POP_UP.size() == scenes_dict.size(), "PopUp scenes aren't equal")
	for key in scenes_dict:
		assert(scenes_dict[key] != null, "Popup Scene failed to load!")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") and scenes_dict[POP_UP.WIN_TSCN].is_inside_tree():
		self.remove_child(self.get_child(-1))

func call_scene(pop_up: POP_UP) -> Node:
	var scene_inst = scenes_dict[pop_up]
	if scene_inst.is_inside_tree():
		self.move_child(scene_inst, -1)
	else:
		self.add_child(scenes_dict[pop_up])
	return scene_inst
