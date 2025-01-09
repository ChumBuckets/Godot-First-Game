extends TileMap

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var state = 2

func _ready() -> void:
	animation_player.play("Show2")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Swap") and state == 1:
		print("swap1")
		animation_player.play("Show2")
		state = 2
	elif Input.is_action_just_pressed("Swap") and state == 2:
		print("swap1")
		animation_player.play("Hide2")
		state = 1
