extends KinematicBody2D

enum STATES { IDLE, PATROLING, FLEEING, DEAD }
var curr_state
var speed = 20
var player
var rng = RandomNumberGenerator.new()

onready var detection_area = $DetectionArea

onready var idle_timer = $IdleTimer
onready var patrolling_timer = $PatrollingTimer
onready var dead_timer = $DeadTimer

onready var animation_player = $AnimationPlayer

var patrol_timer_running = false

func _ready():
	rng = RandomNumberGenerator.new()
	curr_state = STATES.PATROLING
	detection_area.connect("body_entered", self,"_on_body_entered")
	detection_area.connect("body_exited", self, "_on_body_exited")
	
	patrolling_timer.connect("timeout", self, "_on_patrol_end")
	idle_timer.connect("timeout",self,"_on_idle_end")
	
func _physics_process(delta):
	match curr_state:
		STATES.IDLE:
			animation_player.play("idle")
			pass
		STATES.PATROLING:
			if not patrol_timer_running:
				patrol_movement(delta)
				patrol_timer_running = true
			pass
		STATES.FLEEING:
			pass
		STATES.DEAD:
			pass
	pass
	
func patrol_movement(delta):
	animation_player.play("walk")
	rng.randomize()
	var x = rng.randi_range(-1, 1)
	rng.randomize()
	var y = rng.randi_range(-1, 1)
	var direction = Vector2(x,y)
	move_and_slide(direction * speed, Vector2.UP)
	pass
	
func fleeing_movement(delta):
	pass
	
func _on_body_entered(body):
	return
	if curr_state == STATES.IDLE or curr_state == STATES.PATROLING:
		curr_state = STATES.FLEEING
	pass
	
func _on_body_exited(body):
	return
	curr_state = STATES.IDLE
	pass
	
func _on_patrol_end():
	curr_state = STATES.IDLE
	patrol_timer_running = false
	
func _on_idle_end():
	curr_state = STATES.PATROLING


