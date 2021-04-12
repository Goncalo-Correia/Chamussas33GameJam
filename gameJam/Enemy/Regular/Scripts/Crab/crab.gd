extends EnemyInterface

class_name Crab

func _on_detect(body):
	._on_detect(body)
	curr_state = STATES.FLEEING
	animation_player.play("fleeing")
	
