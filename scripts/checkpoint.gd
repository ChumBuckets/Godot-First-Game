extends Area2D

signal checkpoint_reached(position)
@onready var static_body_2d: StaticBody2D = $StaticBody2D


func _on_body_entered(body):
	emit_signal("checkpoint_reached", static_body_2d.global_position)
