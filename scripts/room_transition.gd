extends Node
@onready var static_body_top: StaticBody2D = $StaticBodyTop
@onready var static_body_bottom: StaticBody2D = $StaticBodyBottom
@onready var static_body_left: StaticBody2D = $StaticBodyLeft
@onready var static_body_right: StaticBody2D = $StaticBodyRight
@export var zoom = 3.99
@onready var zoomV2 = Vector2(zoom, zoom)
@onready var camera: Camera2D = $"../../Player/Camera"




func _on_detect_2_body_entered(body: Node2D) -> void:
	camera.limit_top = static_body_top.global_position.y
	camera.limit_bottom = static_body_bottom.global_position.y
	camera.limit_left = static_body_left.global_position.x
	camera.limit_right = static_body_right.global_position.x
	camera.zoom = zoomV2/1.5
