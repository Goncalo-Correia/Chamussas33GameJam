extends Node

onready var audioLibrary = get_parent().get_node("AudioLibrary")

func _ready():
	audioLibrary.playSound("Lobby")
	$VBoxContainer/VBoxContainer/StartGame.grab_focus()

func _on_StartGame_pressed():
	pass

func _on_HowToPlay_pressed():
	pass

func _on_ExitGame_pressed():
	pass
