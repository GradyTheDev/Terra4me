extends Control

@export var number_of_planets_to_win = 1
@export var ambient_music: AudioStream
@export var win_sound: AudioStream

#func _ready():
#	if ambient_music:
#		var ambient_player = AudioStreamPlayer.new()
#		ambient_player.volume_db = - 12
#		ambient_player.process_mode = Node.PROCESS_MODE_ALWAYS
#		ambient_player.stream = ambient_music
#		ambient_player.autoplay = true
#		self.add_child(ambient_player)

func _on_planet_planet_compleated():
	number_of_planets_to_win -= 1
	if number_of_planets_to_win <= 0:
		LevelUnlocker.unlock_next_level()
		GlobalPopupSpace.call_scene(GlobalEnums.POP_UP.WIN_TSCN)
		
		var audio_player = OneShotAudio.new(win_sound)
		audio_player.bus = AudioServer.get_bus_name(GlobalEnums.BUS.MUSIC)
		GlobalSounds.add_child(audio_player)
