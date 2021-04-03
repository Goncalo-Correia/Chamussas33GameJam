extends RigidBody2D

var direction
var speed = 180
var player


func _ready():
	look_at(get_global_mouse_position())
	self.linear_velocity = direction * speed

func _integrate_forces(state):
	pass
	
func _set_direction(dir):
	direction = dir
	
func _set_player(p):
	player = p
	

	
