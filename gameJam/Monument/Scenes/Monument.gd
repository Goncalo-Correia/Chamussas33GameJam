extends Area2D

var collected = false


func _ready():
	connect("body_entered", self, "_on_body_entered")
	
	
func _on_body_entered():
	collected = true
