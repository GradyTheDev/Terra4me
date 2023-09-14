class_name ButtonSound
extends Button

@export_group("Sounds")
@export var on_click_sound: AudioStream
@export var on_hover_sound: AudioStream



func play_sound(sound: AudioStream):
	var audio_player = OneShotAudio.new(sound)
	audio_player.bus = AudioServer.get_bus_name(GlobalEnums.BUS.UI)
	GlobalSounds.add_child(audio_player)


func _on_pressed():
	play_sound(on_click_sound)

func _on_mouse_entered():
	if not self.disabled:
		play_sound(on_hover_sound)
