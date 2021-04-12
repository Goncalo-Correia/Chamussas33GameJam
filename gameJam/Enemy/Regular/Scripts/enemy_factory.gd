extends Node2D

var CRAB = preload("res://Enemy/Regular/Scenes/Crab/Crab.tscn")
var FISH = preload("res://Enemy/Regular/Scenes/Fish/Fish.tscn")
var SWORDFISH = preload("res://Enemy/Regular/Scenes/Fish/Swordfish.tscn")
var SHARK = preload("res://Enemy/Regular/Scenes/Shark/Shark.tscn")
var BLUE_SHARK = preload("res://Enemy/Regular/Scenes/Shark/Blue.tscn")
var FAT_SHARK = preload("res://Enemy/Regular/Scenes/Shark/FatShark.tscn")

export var create_enemy_timer_step = 5

signal append_enemy

enum ENEMY_TYPE { 
		CRAB, 
		FISH, 
		SWORDFISH, 
		SHARK, 
		FAT_SHARK, 
		BLUE_SHARK 
		}

# CRABS
export var create_crab = true

# FISHES
export var create_fish = false
export var create_swordfish = false

# SHARKS
export var create_shark = false
export var create_fat_shark = false
export var create_blue_shark = false

var enemy_types_arr = []
var rng
onready var timer = $Timer

func _ready():
	
	bootstrap()
	timer.wait_time = create_enemy_timer_step
	timer.connect("timeout",self,"create_random_enemy")
	timer.start()

func create_random_enemy():
	print("HERE")
	randomize()
	rng = RandomNumberGenerator.new()
	var index = rng.randi_range(0, enemy_types_arr.size() - 1)
	create_enemy(enemy_types_arr[index])
	
func create_enemy(enemy_type):
	var instance
	match enemy_type:
		ENEMY_TYPE.CRAB:
			instance = CRAB.instance()
		ENEMY_TYPE.FISH:
			instance = FISH.instance()
		ENEMY_TYPE.SWORDFISH:
			instance = SWORDFISH.instance()
		ENEMY_TYPE.SHARK:
			instance = SHARK.instance()
		ENEMY_TYPE.BLUE_SHARK:
			instance = BLUE_SHARK.instance()
		ENEMY_TYPE.FAT_SHARK:
			instance = FAT_SHARK.instance()
	instance.position = position
	get_parent().add_child(instance)
	
func bootstrap():
	if create_crab:
		enemy_types_arr.append(ENEMY_TYPE.CRAB)
	if create_fish:
		enemy_types_arr.append(ENEMY_TYPE.FISH)
	if create_swordfish:
		enemy_types_arr.append(ENEMY_TYPE.SWORDFISH)
	if create_shark:
		enemy_types_arr.append(ENEMY_TYPE.SHARK)
	if create_blue_shark:
		enemy_types_arr.append(ENEMY_TYPE.BLUE_SHARK)
	if create_fat_shark:
		enemy_types_arr.append(ENEMY_TYPE.FAT_SHARK)
		
	
	


