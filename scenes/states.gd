extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Starting State
var state = 2
func _ready() -> void:
	animation_player.play("State1")

# State swap
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Swap") and state == 1:
		print("swap1")
		animation_player.play("State1")
		state = 2
	elif Input.is_action_just_pressed("Swap") and state == 2:
		print("swap1")
		animation_player.play("State2")
		state = 1
