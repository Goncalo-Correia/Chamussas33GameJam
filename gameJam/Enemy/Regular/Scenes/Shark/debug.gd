extends Label

enum STATES { IDLE, PATROLING, FLEEING, DEAD , NETTED, CHASING }

var parent

func _ready():
	parent = get_parent()
	
func _process(delta):
	match parent.curr_state:
		STATES.DEAD:
			text = "DEAD"
		STATES.FLEEING:
			text = "FLEEING"
		STATES.IDLE:
			text = "IDLE"
		STATES.PATROLING:
			text = "PATROLLING"
		STATES.NETTED:
			text = "NETTED"
		STATES.CHASING:
			text = "CHASING"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
