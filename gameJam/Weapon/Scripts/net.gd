extends Area2D

export var speed = 150
var direction = Vector2.ZERO
var player

func _ready():
	pass # Replace with function body.
	
func _process(delta):
	
	position += direction * speed * delta
	update()
	
func _set_direction(dir):
	direction = dir
	
func _set_player(p):
	player = p
	
