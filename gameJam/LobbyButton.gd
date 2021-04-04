tool
extends TextureButton

export (String) var button_text = "placeholder"
export(int) var fish_margin_from_center = 100

func _ready():
	setup_text()
	hide_fish()
	set_focus_mode(true)
	
func _process(delta):
	if Engine.editor_hint:
		setup_text()
		show_fish()
	
func setup_text():
	$RichTextLabel.bbcode_text = "[center] %s [/center]" % [button_text]
	
func show_fish():
	for fish in [$LeftFish, $RightFish]:
		fish.visible = true
		fish.global_position.y = rect_global_position.y + (rect_size.y / 3)
		
	var center_x = rect_global_position.x + (rect_size.x / 2)
	$LeftFish.global_position.x = center_x - fish_margin_from_center
	$RightFish.global_position.x = center_x + fish_margin_from_center
	

func hide_fish():
	for fish in [$LeftFish, $RightFish]:
		fish.visible = false

func _on_TextureButton_focus_entered():
	show_fish()

func _on_TextureButton_focus_exited():
	hide_fish()

func _on_TextureButton_mouse_entered():
	grab_focus()
