extends Area2D

@onready var state_yellow: Node = $"../StateYellow"



func _on_body_entered(body: Node2D) -> void:
	state_yellow.call_states()
	queue_free()
 
