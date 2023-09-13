extends PanelContainer

const PAUSE_REASON_NAME = {
	GlobalEnums.PAUSE_REASON.PAUSE: "Paused",
	GlobalEnums.PAUSE_REASON.FAILED: "Failed",
}
@export var reason: GlobalEnums.PAUSE_REASON:
	set(new):
		reason = new
		$Title.text = "Game %s" % PAUSE_REASON_NAME[reason]

func _enter_tree():
	get_tree().paused = true

func _exit_tree():
	get_tree().paused = false


func close_window():
	get_parent().remove_child(self)
	


func _on_back_button_up():
	close_window()
	$Title.text = "Reason"

func _on_restart_button_up():
	pass # Replace with function body.


func _on_settings_button_up():
	GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.SETTINGS)


func _on_main_menu_button_up():
	get_tree().change_scene_to_file("res://code/menus/main/main_menu.tscn")
	close_window()
