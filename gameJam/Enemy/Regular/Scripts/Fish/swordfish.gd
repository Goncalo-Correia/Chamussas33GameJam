extends EnemyInterface


func _on_detect(body):
	._on_detect(body)
	curr_state = STATES.CHASING
	
func state_chasing():
	.state_chasing()
	if player != null:
		look_at(player.global_position)
		
func _flip_direction():
	pass
