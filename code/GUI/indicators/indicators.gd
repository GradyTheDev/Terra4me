extends VBoxContainer

signal spike_action_made(terra_packed)

@export var is_debug := true
@onready var indicators = self.get_children()

func _ready():
	if is_debug:
		for indicator in indicators:
			indicator.is_debug = true

func _on_spike_action_made(terra_packed):
	for indicator in indicators:
		indicator.start_cooldown()
	emit_signal("spike_action_made", terra_packed)
