extends Control


onready var label = $Label
var player

func set_text(n):
	label.text = "x" + str(n)
	
func _process(delta):
	if player != null:
		label.text = "x" + str(player.score)
	
func _set_player(p):
	player = p
	

