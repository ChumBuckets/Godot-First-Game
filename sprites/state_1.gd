extends AnimatableBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var state = 1

func state_swap():
	if state == 1:
		animation_player.play("Hide")
		state = 2
	else:
		animation_player.play("RESET")
		state = 1
	
	print(state)
