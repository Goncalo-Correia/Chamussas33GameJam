extends Node2D

onready var soundTrack01 = $SoundTrack01
onready var soundTrack02 = $SoundTrack02
onready var soundTrack03 = $SoundTrack03
onready var seaAmbienceSound = $SeaAmbience

var weapon_factory
var message;
var dialog;

onready var player = $Player

var collected = 0;

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

func _on_Monument_collected(text):
	collected += 1
	if(text != ""):
		message = text;
		startDialog("Message");

func _on_message(text):
	message = text;
	startDialog("Message");
	
func startDialog(timeline):
	dialog = Dialogic.start(timeline, false, "res://addons/dialogic/Dialog.tscn", false)
	setDialogVariables();
	$CanvasLayer.add_child(dialog);

func setDialogVariables():
	Dialogic.set_variable("message", message)
