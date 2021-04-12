extends EnemyInterface

func _on_detect(body):
	._on_detect(body)
	curr_state = STATES.CHASING
	
