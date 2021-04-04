extends Area2D

var collected = false

signal collected

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
	
func _on_body_entered():
	if not collected:
		get_parent().collected += 1
