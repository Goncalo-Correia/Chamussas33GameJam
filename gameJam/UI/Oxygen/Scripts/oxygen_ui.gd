extends Control

onready var progress = $TextureProgress

var player

func _set_player(p):
	player = p
	
func _process(delta):
	if player != null:
		_decrement(player.oxygen_depletion_modifier)

func _set_value(val):
	progress.value = val
	
func _decrement(val):
	progress.value -= val
