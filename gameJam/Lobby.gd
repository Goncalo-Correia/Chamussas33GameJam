extends Node

func _ready():
	$LobbyNode/LobbySoundtrack.play()
	$LobbyNode/VBoxContainer/VBoxContainer/StartGame.grab_focus()

func _on_StartGame_pressed():
	$LobbyNode/LobbySoundtrack.stop()
	
func _on_ExitGame_pressed():
	$LobbyNode/LobbySoundtrack.stop()
