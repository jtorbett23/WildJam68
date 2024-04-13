extends Node

class_name Audio

var num_players = 8
var bus = "master"

var sound_players = [] # Reference of all sound players
var available = []  # The available sound players.
var queue = []  # The queue of sounds to play.

var music_player : AudioStreamPlayer
var audio_path : String = "assets/audio"

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		p.name = "Sound Player %s" % i
		add_child(p)
		available.append(p)
		sound_players.append(p)
		p.finished.connect(_on_sound_finished.bind(p))
		p.bus = bus
	music_player = AudioStreamPlayer.new()
	music_player.name = "Music Player"
	music_player.finished.connect(_on_music_finished.bind(music_player))
	add_child(music_player)
	

func _on_music_finished(stream):
	# When finished playing a music track, play it again.
	stream.play()

func _on_sound_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play_sound(sound_name):
	queue.append(audio_path + "/sound/" + sound_name)

func play_music(music_name):
	music_player.stream = load(audio_path + "/music/" + music_name)
	music_player.play()

#TODO
func change_music_volume():
	pass

#TODO
func change_sound_volume():
	pass

func _process(_delta):
	# Play a queued sound if any players are available.
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
