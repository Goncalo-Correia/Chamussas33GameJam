extends Control

onready var progress = $ProgressBar

var player

func _set_player(p):
	player = p
	
func _process(delta):
	if player != null:
		_decrement(1)

func _set_value(val):
	progress.value = val
	
func _decrement(val):
	set_pro
	progress.value -= val
