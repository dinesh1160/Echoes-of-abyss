extends Node2D

@onready var background_music: AudioStreamPlayer = $Background_music
@onready var chase_music: AudioStreamPlayer = $Chase_music
@onready var swim_music: AudioStreamPlayer = $swim_music
@onready var crash_music: AudioStreamPlayer = $crash_music

func play_background():
	background_music.play()

func play_swim():
	if not swim_music.playing:
		swim_music.play()
		
func play_crash():
	if not crash_music.playing:
		crash_music.play()

func set_swim_volume(volume: float):
	swim_music.volume_db = volume
