extends State

class_name MoveState

func _ready():
	animated_sprite.play("move")
	pass

func _physics_process(_delta):
	pass

func move():
	
	persistent_state.move_and_collide(persistent_state.velocity);
