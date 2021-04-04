extends Node2D

onready var soundTrack01 = $SoundTrack01
onready var soundTrack02 = $SoundTrack02
onready var soundTrack03 = $SoundTrack03
onready var seaAmbienceSound = $SeaAmbience
onready var player = $Player

var collected = 0

func _ready():
	soundTrack01.play()
	seaAmbienceSound.play()

func _on_SoundTrack01_finished():
	soundTrack02.play()


func _on_SoundTrack02_finished():
	soundTrack03.play()


func _on_SoundTrack03_finished():
	soundTrack01.play()


func _on_SeaAmbience_finished():
	seaAmbienceSound.play()

func add_to_collection():
	collected += 1

