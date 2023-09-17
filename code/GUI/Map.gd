extends TextureRect

func _ready():
	var tween: Tween = get_tree().create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rotation", deg_to_rad(10), 5)
	tween.tween_property(self, "rotation", deg_to_rad(0), 5)
