extends CanvasLayer

onready var AnimationN := $Control/AnimationPlayer

func run_animation(in_anim):
	AnimationN.play(in_anim)
	yield(AnimationN, 'animation_finished')
