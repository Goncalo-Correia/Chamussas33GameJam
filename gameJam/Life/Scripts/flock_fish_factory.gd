extends Node2D

var FLOCK_FISH_INSTANCE = preload("res://Life/Scenes/FlockFish.tscn")

onready var timer = $Timer

export var direction = Vector2.ZERO
export var rot = 0

func _ready():
	timer.connect("timeout",self,"create_flock")
	pass

func create_flock():
	
	var instance = FLOCK_FISH_INSTANCE.instance()
	instance.rotation_degrees = rot
	instance.direction = direction
	instance.position = position
	get_parent().add_child(instance)
	
	
