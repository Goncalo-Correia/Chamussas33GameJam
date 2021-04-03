extends Sprite

var distance = 25

func _process(delta):
	
	var mouse_pos = get_global_mouse_position()
	
	var angle = get_angle_to(mouse_pos)
	var point = Vector2(0,0)
	position = point + Vector2(cos(angle), sin(angle)) * distance
	#look_at(mouse_pos)
	
	
	
