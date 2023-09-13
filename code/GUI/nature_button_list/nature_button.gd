extends ButtonSound

signal button_up_with_stats(stats)

@export var terra_packs: PackTerraPack



func _init():
	self.button_up.connect(_on_button_up)

func _on_button_up():
	emit_signal("button_up_with_stats", terra_packs)
