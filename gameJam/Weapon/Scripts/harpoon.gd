extends RigidBody2D

var direction
var speed = 180
var player

var weapon_type = "harpoon"

func _ready():
	look_at(get_global_mouse_position())
	self.linear_velocity = direction * speed
	player.hitbox.connect("body_entered", self, "_player_pickup")

func _integrate_forces(state):
	pass
	
func _set_direction(dir):
	direction = dir
	
func _set_player(p):
	player = p
	
func _player_pickup(body):
	player.harpoons += 1
	queue_free()

	

	
