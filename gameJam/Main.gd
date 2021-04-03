extends Node2D

var NET_INSTANCE = preload("res://Weapon/Scenes/Net.tscn")
var HARPOON_INSTANCE = preload("res://Weapon/Scenes/Harpoon.tscn")
var KNIFE_INSTANCE = preload("res://Weapon/Scenes/Knife.tscn")
enum WEAPONS { NET, KNIFE, HARPOON }
var weapon_factory
onready var player = $Player

func _ready():
	player.connect("shoot", self, "_on_player_shoot")
	weapon_factory = WeaponFactory.new()

func _on_player_shoot(dir):
	var instance
	match player.get_weapon():
		WEAPONS.NET:
			instance = NET_INSTANCE.instance()
		WEAPONS.HARPOON:
			instance = HARPOON_INSTANCE.instance()
		WEAPONS.KNIFE:
			instance = KNIFE_INSTANCE.instance()
	
	var cursor = player.get_cursor()
	instance.position = cursor.global_position
	var direction = (get_global_mouse_position() - cursor.global_position).normalized()
	instance._set_direction(direction)
	instance._set_player(player)
	add_child(instance)
	
