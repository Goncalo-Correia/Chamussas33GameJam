extends Node

signal start

func _ready():
	if $LobbyNode.visible:
		$LobbyNode/LobbySoundtrack.play()
		$LobbyNode/VBoxContainer/VBoxContainer/StartGame.grab_focus()

func _on_StartGame_pressed():
	emit_signal("start")
	$LobbyNode/LobbySoundtrack.stop()
	
func _on_ExitGame_pressed():
	$LobbyNode/LobbySoundtrack.stop()
	get_tree().quit()
