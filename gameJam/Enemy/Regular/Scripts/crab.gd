extends KinematicBody2D

enum STATES { IDLE, PATROLING, FLEEING, DEAD }
var curr_state
var speed = 40
var player
var rng = RandomNumberGenerator.new()
var curr_direction = Vector2.ZERO
var netted = false

onready var detection_area = $DetectionArea
onready var hitbox = $Hitbox

onready var idle_timer = $IdleTimer
onready var patrolling_timer = $PatrollingTimer
onready var dead_timer = $DeadTimer
onready var net_timer = $NetTimer

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
	hitbox.connect("area_entered", self, "_area_entered")
	
	patrolling_timer.connect("timeout", self, "_on_patrol_end")
	idle_timer.connect("timeout",self,"_on_idle_end")
	net_timer.connect("timeout", self,"_net_timeout")
	
	
func _physics_process(delta):
	
	if is_dead:
		$Dead.modulate.a -= 0.01
		if $Dead.modulate.a <= 0:
			queue_free()
		return
	elif netted:
		return
		
	
	match curr_state:
		STATES.DEAD:
			animation_player.play("dead")
			is_dead = true
			pass
		STATES.FLEEING:
			animation_player.play("flee")
			if player != null:
				 curr_direction = -global_position.direction_to(player.global_position)
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
	if curr_state == STATES.IDLE or curr_state == STATES.PATROLING:
		curr_state = STATES.FLEEING
		curr_direction = Vector2.ZERO
		idle_timer_running = false
		patrol_timer_running = false
		idle_timer.stop()
		patrolling_timer.stop()
		player = body
	pass
	
func _on_body_exited(body):
	curr_state = STATES.IDLE
	pass
	
func _on_patrol_end():
	curr_state = STATES.IDLE
	curr_direction = Vector2.ZERO
	patrol_timer_running = false
	
func _on_idle_end():
	curr_state = STATES.PATROLING
	idle_timer_running = false
	
func _net_timeout():
	netted = false
	$Net.visible = false
	
func _on_kill(body):
	if player != null:
		player.score += 5
	idle_timer.stop()
	patrolling_timer.stop()
	curr_state = STATES.DEAD
	
func _area_entered(area):
	if area.weapon_type == "net":
		print("netted")
		netted = true
		$Net.visible = true
		net_timer.start()
		area.queue_free()
	else:
		idle_timer.stop()
		patrolling_timer.stop()
		
		curr_state = STATES.DEAD
		if player != null:
			player.score += 5


