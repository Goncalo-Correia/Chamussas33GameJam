extends Node2D

class_name WeaponFactory

var NET_INSTANCE = preload("res://Weapon/Scenes/Net.tscn")
var HARPOON_INSTANCE = preload("res://Weapon/Scenes/Harpoon.tscn")

enum WEAPONS { NET, KNIFE, HARPOON }


func create_weapon(player, dir):
	var instance
	
	return instance
	
	
