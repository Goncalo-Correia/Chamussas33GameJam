extends KinematicBody2D

enum STATES { IDLE, PATROLING, CHASING, DEAD }
var curr_state
export var speed = 55
var player
var rng = RandomNumberGenerator.new()
var curr_direction = Vector2.ZERO
var netted = false
export var life = 8

onready var detection_area = $DetectionArea
onready var hitbox = $Hitbox

onready var idle_timer = $IdleTimer
onready var patrolling_timer = $PatrollingTimer
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
		animation_player.play("dead")
		$Dead.modulate.a -= 0.01
		if $Dead.modulate.a <= 0:
			queue_free()
		return
	elif netted:
		return
		
	if player != null:
		animation_player.play("chase")
		curr_direction = global_position.direction_to(player.global_position)
		position += curr_direction * speed * delta
		if curr_direction.x < 0 and not $Main.flip_h:
			$Main.flip_h = not $Main.flip_h
			$CollisionShape2D.position.x = -$CollisionShape2D.position.x 
		elif curr_direction.x > 0 and $Main.flip_h:
			$Main.flip_h = not $Main.flip_h
			$CollisionShape2D.position.x = -$CollisionShape2D.position.x
				
		if curr_direction.x < 0 and not $Main.flip_h:
			$Main.flip_h = not $Main.flip_h
			$CollisionShape2D.position.x = -$CollisionShape2D.position.x 
		elif curr_direction.x > 0 and $Main.flip_h:
			$Main.flip_h = not $Main.flip_h
			$CollisionShape2D.position.x = -$CollisionShape2D.position.x 
	
		position += curr_direction * speed * delta
	pass
	
func patrol_movement(delta):
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
	player = null
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
	idle_timer.stop()
	patrolling_timer.stop()
	life -= 2
	if life <= 0:
		is_dead = true
		if( player != null):
			player.score += 23
		curr_state = STATES.DEAD
	else:
		curr_state = STATES.IDLE
	
func _area_entered(area):
	if area.weapon_type == "net":
		netted = true
		$Net.visible = true
		net_timer.start()
		area.queue_free()
		
	elif area.weapon_type == "knife":
		life -= 1
	idle_timer.stop()
	patrolling_timer.stop()
	life -= 1
	if life <= 0:
		is_dead = true
		if( player != null):
			player.score += 18
		curr_state = STATES.DEAD
	else:
		curr_state = STATES.IDLE


