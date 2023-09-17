extends TextureRect

func _ready():
	var tween = self.create_tween().set_loops().set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "rotation", deg_to_rad(5), 5)
	tween.tween_property(self, "rotation", deg_to_rad(-5), 5)
