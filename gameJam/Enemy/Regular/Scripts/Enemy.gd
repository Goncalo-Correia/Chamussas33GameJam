extends KinematicBody2D

class_name EnemyInterface

export var speed = 10
export var mass = 1200
export var hitpoints = 5
export var score = 10

var player

# STATES
enum STATES { IDLE, PATROLING, FLEEING, DEAD , NETTED, CHASING }
var curr_state
var is_dead = false
var netted = false

# COLLISION
onready var detection_area = $DetectionArea
onready var hitbox = $Hitbox

# TIMERS
onready var idle_timer = $IdleTimer
onready var patrolling_timer = $PatrollingTimer
onready var dead_timer = $DeadTimer
onready var net_timer = $NetTimer
var patrol_timer_running = false
var idle_timer_running = false
var net_timer_running = false

# SPRITE ANIMATION
onready var sprite = $Main
onready var sprite_dead = $Dead
onready var net = $Net
onready var animation_player = $AnimationPlayer

var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	rng = RandomNumberGenerator.new()
	curr_state = STATES.IDLE
	detection_area.connect("body_entered", self,"_on_detect")
	detection_area.connect("body_exited", self, "_on_loose_detection")
	
	hitbox.connect("body_entered", self,"_on_kinematic_weapon_entered")
	hitbox.connect("area_entered", self, "_area_weapon_entered")
	
	patrolling_timer.connect("timeout", self, "_on_patrol_end")
	idle_timer.connect("timeout",self,"_on_idle_end")
	net_timer.connect("timeout", self,"_net_timeout")
	
	
func _physics_process(delta):
	
	match curr_state:
		STATES.DEAD:
			state_dead()
			return;
		STATES.FLEEING:
			state_fleeing()
		STATES.IDLE:
			state_idle()
		STATES.PATROLING:
			state_patrol()
		STATES.NETTED:
			state_netted()
		STATES.CHASING:
			state_chasing()
			
	_flip_direction()
	
	move_and_slide(velocity * speed)
	
	
func state_patrol():
	if not patrol_timer_running:
		patrolling_timer.start()
		patrol_timer_running = true
		rng.randomize()
		var x = rng.randi_range(-1, 1)
		var y = rng.randi_range(-1, 1)
		velocity = Vector2(x,y)
	
func state_fleeing():
	if player != null:
		 velocity = -global_position.direction_to(player.global_position)

func state_dead():
	idle_timer.stop()
	patrolling_timer.stop()
	if sprite_dead.modulate.a == 1:
		animation_player.play("dead")
	velocity = Vector2.ZERO
	sprite_dead.modulate.a -= 0.01
	if sprite_dead.modulate.a <= 0:
		queue_free()

func state_idle():	
	velocity = Vector2.ZERO
	animation_player.play("idle")
	if not idle_timer_running:
		idle_timer_running = true
		idle_timer.start()
	
func state_netted():
	velocity = Vector2.ZERO
	pass
	
func state_chasing():
	if player != null:
		 velocity = SteeringBehaviour.follow(
			velocity,
			global_position,
			player.global_position,
			speed,
			mass )

func _flip_direction():
	if velocity.x < 0 and not sprite.flip_h:
		sprite.flip_h = not sprite.flip_h
	elif velocity.x > 0 and sprite.flip_h:
		sprite.flip_h = not sprite.flip_h
	
func _on_detect(body):
	idle_timer.stop()
	patrolling_timer.stop()
	var patrol_timer_running = false
	var idle_timer_running = false
	player = body
	
func _on_loose_detection(body):
	curr_state = STATES.IDLE
	pass
	
func _on_patrol_end():
	curr_state = STATES.IDLE
	velocity = Vector2.ZERO
	patrol_timer_running = false
	
func _on_idle_end():
	curr_state = STATES.PATROLING
	idle_timer_running = false
	
func _net_timeout():
	netted = false
	net.visible = false
	curr_state = STATES.PATROLING
	
func _on_kinematic_weapon_entered(body):
	if( player != null):
		player.score += score 
		hitpoints -= 1 #BODY MODIFIER
	idle_timer.stop()
	patrolling_timer.stop()
	if hitpoints <= 0:
		curr_state = STATES.DEAD
	
func _area_weapon_entered(area):
	if area.weapon_type == "net":
		netted = true
		curr_state = STATES.NETTED
		net.visible = true
		net_timer.start()
		area.queue_free()
	else:
		idle_timer.stop()
		patrolling_timer.stop()
		hitpoints -= 1
		if hitpoints <= 0:
			curr_state = STATES.DEAD
			if( player != null):
				player.score += score 


