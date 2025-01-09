extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var in_jump = false


func _ready() -> void:
	animation_player.play("RESET")

func  _process(delta: float) -> void:

	if (Input.is_action_pressed("Jump") or Input.is_action_just_pressed("Jump")) and in_jump == true:
		animation_player.play("Hide")
		timer.start()



func _on_area_2d_2_body_entered(body: Node2D) -> void:
	in_jump = true


func _on_area_2d_2_body_exited(body: Node2D) -> void:
	in_jump = false


func _on_timer_timeout() -> void:
	animation_player.play("RESET")
