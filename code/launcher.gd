extends CanvasLayer

func _ready():
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://code/menus/main/main_menu.tscn")
