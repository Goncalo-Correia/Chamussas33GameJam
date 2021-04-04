extends Node2D

var LOBBY = preload("res://Lobby.tscn")
var DEEP_SEA = preload("res://Main.tscn")

var lobby
var deep_sea

func _ready():
	var lobby = LOBBY.instance()
	lobby.connect("start", self, "change_to_deep_sea")
	add_child(lobby)

func change_to_lobby():
	print("here")
	remove_child(get_child(0))
	var lobby = LOBBY.instance()
	lobby.connect("start", self, "change_to_deep_sea")
	add_child(lobby)
	
func change_to_deep_sea():
	remove_child(get_child(0))
	var deep_sea = DEEP_SEA.instance()
	add_child(deep_sea)
