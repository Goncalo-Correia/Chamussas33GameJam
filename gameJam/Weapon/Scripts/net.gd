extends Area2D

export var speed = 150
var direction = Vector2.ZERO
var player
var dissolving = false
onready var sprite = $Sprite

const DISSOLVING_RATIO = 0.05

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.connect("animation_finished",self,"_on_animation_finish")
	animation_player.play("throw")

	pass # Replace with function body.
	
func _process(delta):
	
	position += direction * speed * delta
	if dissolving:
		sprite.modulate.a -= DISSOLVING_RATIO
		if sprite.modulate.a <= 0:
			queue_free()
		
	
func _set_direction(dir):
	direction = dir
	
func _set_player(p):
	player = p
	
func _on_animation_finish(name):
	dissolving = true
	
