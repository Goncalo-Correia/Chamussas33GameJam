extends Area2D


export var speed = 150
var direction = Vector2.ZERO
var player
onready var tween = $Tween
onready var sprite = $Sprite
var knife_speed = 0.2

var is_animation_player = false
var going = true

func _ready():
	tween.connect("tween_completed", self, "_on_tween_completed")
	play_tween()
	

func play_tween():
	look_at(get_global_mouse_position())
	var from = player.global_position if going else player.get_cursor().global_position
	var to = player.get_cursor().global_position if going else player.global_position
	tween.interpolate_property(
		sprite, 
		"global_position",
		from,
		to, 
		knife_speed,
		Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	
func _process(delta):
	pass
	
func _set_direction(dir):
	direction = dir
	
func _set_player(p):
	player = p
	
func _on_tween_completed(obj,path):
	if going:
		going = false
		play_tween()
	else:
		queue_free()
	
	
	
