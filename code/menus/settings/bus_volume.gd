@tool
extends Control

const BUS_NAMES = {
	GlobalEnums.BUS.MASTER: "Master",
	GlobalEnums.BUS.MUSIC: "Music",
	GlobalEnums.BUS.SFX: "SFX",
	GlobalEnums.BUS.UI: "UI",
}

@export var bus: GlobalEnums.BUS:
	set(new):
		bus = new
		$Name.text = BUS_NAMES[bus]
@onready var mute_value = $HSlider.min_value

func _ready():
	$Name.text = BUS_NAMES[bus]
	$HSlider.value = AudioServer.get_bus_volume_db(bus)


func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus, value)
	if value == mute_value:
		AudioServer.set_bus_mute(bus, true)
		$Name.modulate = Color.RED
	else:
		AudioServer.set_bus_mute(bus, false)
		$Name.modulate = Color.WHITE
