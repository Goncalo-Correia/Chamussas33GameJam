extends Area2D


var player
var _body_type = "oxygen"

# Called when the node enters the scene tree for the first time.
func _ready():
	
	connect("body_entered", self, "_on_area_enter")
	connect("body_exited", self, "_on_area_exited")
	pass # Replace with function body.
	
func _physics_process(delta):
	if player != null:
		player.oxygen_depletion_modifier = -8
	
func _on_area_enter(body):
	player = body
	
	
func _on_area_exited(body):
	player.oxygen_depletion_modifier = 1
	player = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
