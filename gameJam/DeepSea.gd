extends Node2D


onready var player = $Player

var collected = 0

func add_to_collection():
	collected += 1
