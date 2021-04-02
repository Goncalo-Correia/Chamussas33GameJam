# idle_state.gd

extends State

class_name IdleState

func _ready():
	animated_sprite.play("idle")
	pass
	
func _physics_process(_delta):
	
	pass

func move():
	change_state.call_func("move")
	pass
