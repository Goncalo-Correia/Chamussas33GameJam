extends Area2D

var collected = false
export var message = "";


signal collected

func _ready():
	connect("body_entered", self, "_on_body_entered");
	
func _on_body_entered(body):
	if not collected:
		collected = true;
		emit_signal("collected", message)
