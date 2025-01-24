extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer



# Starting State
var state = 2
func _ready() -> void:
	animation_player.play("State1")

func FreezeFrame():
	Engine.time_scale = 0
	await(get_tree().create_timer(0.05, true, false, true).timeout)
	Engine.time_scale = 1.0



# State swap
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Swap") and state == 1:
		print("swap1")
		#FreezeFrame()
		animation_player.play("State1")
		state = 2
		
	elif Input.is_action_just_pressed("Swap") and state == 2:
		print("swap2")
		#FreezeFrame()
		animation_player.play("State2")
		state = 1
