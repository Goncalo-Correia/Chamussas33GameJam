extends Control


var player

enum WEAPONS { NET, KNIFE, HARPOON }

onready var harpoon = $Harpoon
onready var net = $Net
onready var knife = $Knife

func _set_player(p):
	player = p
	
func _ready():
	net._set_key_number(1)
	harpoon._set_key_number(2)
	knife._set_key_number(3)

func _process(_delta):
	
	harpoon._deselect()
	net._deselect()
	knife._deselect()
	
	if player != null:
		harpoon.set_text(player.harpoons)
		net.set_text(player.nets)
		
		match player.curr_weapon:
			WEAPONS.NET:
				net._select()
			WEAPONS.KNIFE:
				knife._select()
			WEAPONS.HARPOON:
				harpoon._select()
	
	
	
	
