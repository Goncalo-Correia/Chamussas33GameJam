extends Sprite

onready var label = $Label


func set_text(val):
	label.text = str(val)
	
func _select():
	set_modulate(Color(1,0.2,0.2,1))
	
func _deselect():
	set_modulate(Color(1,1,1,1))
	


