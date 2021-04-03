extends Sprite

var speed = 90

var color_1 = Color(0.2, 0.4, 0.8,1)
var color_2 = Color(0.4, 1, 0.8,1)
var color_3 = Color(0.8, 0.2, 1,1)
var color_4 = Color(0.2, 0.1, 0.8,1)
var color_5 = Color(1, 0.1, 0.1,1)
var color_6 = Color(1, 1, 0.5,1)
var color_7 = Color(0.5, 1, 0.1,1)
var color_8 = Color(0.8, 1, 0,1)
var color_9 = Color(0.1, 1, 0.1,1)
var color_10 = Color(0.8, 1, 0.4,1)

var colors = [ color_1,color_2,color_3,color_4,color_5,color_6,color_7,color_8,color_9,color_10]

var rng = RandomNumberGenerator.new()

onready var timer = $Timer
onready var animation_player = $AnimationPlayer

var direction

func _ready():
	
	timer.connect("timeout", self, "_timeout")
	rng.randomize()
	var color_index = rng.randi_range(0, 9)
	print(color_index)
	set_modulate(colors[color_index])
	animation_player.play("act")
	
	
func _physics_process(delta):
	position += direction * speed * delta

func _set_direction(dir):
	direction = dir
	
func _timeout():
	queue_free()
	
	
	
	
