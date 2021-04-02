extends Node2D

class_name State

var change_state
var animated_sprite
var persistent_state
var sprite

func _physics_process(_delta):
	persistent_state.move_and_slide(persistent_state.velocity, Vector2.UP)

func setup(change_state, animated_sprite, sprite, persistent_state):
	self.change_state = change_state
	self.animated_sprite = animated_sprite
	self.persistent_state = persistent_state
	self.sprite = sprite

func move():
	pass
