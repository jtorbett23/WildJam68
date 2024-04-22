extends Node

var num_players = 8

var sound_players = [] # Reference of all sound players
var available = []  # The available sound players.
var queue = []  # The queue of sounds to play.

var music_player : AudioStreamPlayer
var audio_path : String = "assets/audio"

var music_level : float
var sound_level : float

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		p.name = "Sound Player %s" % i
		add_child(p)
		available.append(p)
		sound_players.append(p)
		p.finished.connect(_on_sound_finished.bind(p))
		p.bus = "Sound"
	music_player = AudioStreamPlayer.new()
	music_player.name = "Music Player"
	music_player.bus = "Music"
	music_player.finished.connect(_on_music_finished.bind(music_player))
	add_child(music_player)

	sound_level = GameData.get_value("Settings", "sound_level")
	music_level = GameData.get_value("Settings", "music_level")
	change_sound_volume(sound_level)
	change_music_volume(music_level)

func _on_music_finished(stream):
	# When finished playing a music track, play it again.
	stream.play()

func _on_sound_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)

func stop_music():
	music_player.stop()

func play_sound(sound_name):
	queue.append(audio_path + "/sound/" + sound_name)

func play_music(music_name):
	music_player.stream = load(audio_path + "/music/" + music_name)
	music_player.play()

func change_music_volume(level):
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(level/100))

func change_sound_volume(level):
	var sound_bus = AudioServer.get_bus_index("Sound")
	AudioServer.set_bus_volume_db(sound_bus, linear_to_db(level/100))

func _process(_delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
