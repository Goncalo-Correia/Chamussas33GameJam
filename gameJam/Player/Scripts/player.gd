extends KinematicBody2D

class_name PersistentState

var oxygen = 100
var oxygen_depletion_modifier = 1
onready var oxygen_ui = $CanvasLayer/Oxygen

onready var hitbox = $Hitbox

var harpoons = 5
var nets = 5

enum WEAPONS { NET, KNIFE, HARPOON }

var curr_weapon
onready var cursor = $Cursor
onready var knife_cursor = $Position2D/KnifeCursor
onready var weapon_ui = $CanvasLayer/WeaponUI

const ACCELARATION = 10;
const MAX_SPEED = 100;
const FRICTION = 50;

var state;
var state_factory;

signal shoot 

var canMove = false;
var velocity = Vector2.ZERO;
var direction = Vector2.DOWN;

# Called when the node enters the scene tree for the first time.
func _ready():
	state_factory = StateFactory.new();
	weapon_ui._set_player(self)
	oxygen_ui._set_player(self)
	curr_weapon = WEAPONS.NET
	hitbox.connect("body_entered",self,"_on_body_entered")
	hitbox.connect("body_exited",self,"_on_body_exited")
	change_state("idle");
	
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		match curr_weapon:
			WEAPONS.HARPOON:
				if harpoons == 0:
					return
				else:
					harpoons-=1
			WEAPONS.NET:
				if nets == 0:
					return
				else:
					nets -= 1
		emit_signal("shoot", get_global_mouse_position().normalized())

func _process(_delta):
	
	print("Oxygen " + str(oxygen_depletion_modifier) )
	
	if Input.is_action_just_released("weapon_1"):
		knife_cursor.visible = false
		curr_weapon = WEAPONS.NET
	elif Input.is_action_just_released("weapon_2"):
		knife_cursor.visible = false
		curr_weapon = WEAPONS.HARPOON
	elif Input.is_action_just_released("weapon_3"):
		knife_cursor.visible = true
		curr_weapon = WEAPONS.KNIFE
	
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
	
func get_cursor():
	return cursor
	
func get_weapon():
	return curr_weapon
	
func get_knife_cursor():
	return knife_cursor
	
func _on_body_entered(body):
	oxygen_depletion_modifier = 3
	pass
	
func _on_body_exited(body):
	oxygen_depletion_modifier = 1
	pass
	
