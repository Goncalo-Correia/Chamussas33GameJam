extends Control

onready var label = $Label
onready var container = $container


func set_text(value):
	label.text = "x" + str(value)
	
func _set_key_number(n):
	container.set_text(n)
	
func _select():
	container._select()

func _deselect():
	container._deselect()
	
func _ready():
	pass
