extends Control

@export var number_of_planets_to_win = 1
@export var ambient_music: AudioStream
@export var win_sound: AudioStream

func _on_planet_planet_compleated():
	number_of_planets_to_win -= 1
	if number_of_planets_to_win <= 0:
		$Camera2D.move_camera_to($Camera2D.Direction.LEFT)
		await get_tree().create_timer(0.1).timeout
		
		LevelUnlocker.unlock_next_level()
		GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.WIN_TSCN)
		
		var audio_player = OneShotAudio.new(win_sound)
		audio_player.bus = AudioServer.get_bus_name(GlobalEnums.BUS.MUSIC)
		GlobalSounds.add_child(audio_player)
