extends TileMap

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var state = 1

func _ready() -> void:
	animation_player.play("Hide")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Swap") and state == 1:
		print("swap2")
		animation_player.play("Show")
		state = 2
	elif Input.is_action_just_pressed("Swap") and state == 2:
		print("swap2")
		animation_player.play("Hide")
		state = 1
