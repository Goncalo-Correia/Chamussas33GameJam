extends KinematicBody2D

enum STATES { IDLE, PATROLING, CHASING, DEAD }
var curr_state
export var speed = 10
var player
var rng = RandomNumberGenerator.new()
var curr_direction = Vector2.ZERO

onready var detection_area = $DetectionArea
onready var hitbox = $Hitbox

onready var idle_timer = $IdleTimer
onready var patrolling_timer = $PatrollingTimer

onready var animation_player = $AnimationPlayer

var patrol_timer_running = false
var idle_timer_running = false

var is_dead = false

func _ready():
	rng = RandomNumberGenerator.new()
	curr_state = STATES.PATROLING
	detection_area.connect("body_entered", self,"_on_body_entered")
	detection_area.connect("body_exited", self, "_on_body_exited")
	
	hitbox.connect("body_entered", self,"_on_kill")
	
	patrolling_timer.connect("timeout", self, "_on_patrol_end")
	idle_timer.connect("timeout",self,"_on_idle_end")
	
func _physics_process(delta):
	
	
	
	match curr_state:
		STATES.DEAD:
			animation_player.play("dead")
			is_dead = true
			pass
		STATES.CHASING:
			animation_player.play("chase")
			if player != null:
				look_at(player.global_position)
			if player != null:
				 curr_direction = global_position.direction_to(player.global_position)
			pass
		STATES.IDLE:
			animation_player.play("idle")
			if not idle_timer_running:
				idle_timer_running = true
				idle_timer.start()
			pass
		STATES.PATROLING:
			if not patrol_timer_running:
				patrolling_timer.start()
				patrol_movement(delta)
				patrol_timer_running = true
	position += curr_direction * speed * delta
	pass
	
func patrol_movement(delta):
	
	animation_player.play("walk")
	rng.randomize()
	var x = rng.randi_range(-1, 1)
	var y = rng.randi_range(-1, 1)
	curr_direction = Vector2(x,y)
	pass
	
func fleeing_movement(delta):
	pass
	
func _on_body_entered(body):
	print("enter")
	if curr_state == STATES.IDLE or curr_state == STATES.PATROLING:
		curr_state = STATES.CHASING
		curr_direction = Vector2.ZERO
		idle_timer_running = false
		patrol_timer_running = false
		idle_timer.stop()
		patrolling_timer.stop()
		player = body
	pass
	
func _on_body_exited(body):
	print("exit")
	curr_state = STATES.IDLE
	pass
	
func _on_patrol_end():
	curr_state = STATES.IDLE
	curr_direction = Vector2.ZERO
	patrol_timer_running = false
	
func _on_idle_end():
	curr_state = STATES.PATROLING
	idle_timer_running = false
	
func _on_kill(body):
	idle_timer.stop()
	patrolling_timer.stop()
	curr_state = STATES.DEAD


