extends KinematicBody2D

class_name PersistentState

const ACCELARATION = 10;
const MAX_SPEED = 100;
const FRICTION = 50;

var state;
var state_factory;

var canMove = false;
var velocity = Vector2.ZERO;
var direction = Vector2.DOWN;

# Called when the node enters the scene tree for the first time.
func _ready():
	state_factory = StateFactory.new();
	change_state("idle");

func _process(_delta):
	
	
	var up = Input.is_action_pressed("move_up")
	var down = Input.is_action_pressed('move_down')
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")
	
	var directionAux = Vector2();
	
	directionAux.x = int(right) - int(left); 
	directionAux.y = int(down) - int(up);
	directionAux = directionAux.normalized();
	
	if directionAux != Vector2.ZERO:
		velocity += directionAux * ACCELARATION * _delta;
		velocity = velocity.clamped(MAX_SPEED * _delta);
		direction = directionAux;
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * _delta);
	
	if up || down || left || right || (velocity != Vector2.ZERO):
		move()
	else:
		change_state("idle")

func move():
	state.move()
	
func change_state(new_state_name):
	if state != null:
		state.queue_free();
		
	state = state_factory.get_state(new_state_name).new();
	state.setup(funcref(self, "change_state"),$AnimationPlayer ,$Sprite, self);
	state.name = "current_state";
	add_child(state);
