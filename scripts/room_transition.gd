extends Node
@onready var static_body_top: StaticBody2D = $StaticBodyTop
@onready var static_body_bottom: StaticBody2D = $StaticBodyBottom
@onready var static_body_left: StaticBody2D = $StaticBodyLeft
@onready var static_body_right: StaticBody2D = $StaticBodyRight
@export var Zoom = 3.00
@onready var zoomV2 = Vector2(Zoom, Zoom)
@onready var camera: Camera2D = $"../../Player/Camera"


func _on_detect_2_body_entered(body: Node2D) -> void:
	if camera.limit_top != static_body_top.global_position.y and camera.limit_bottom != static_body_bottom.global_position.y and camera.limit_left != static_body_left.global_position.x and camera.limit_right != static_body_right.global_position.x:
		camera.limit_top = static_body_top.global_position.y
		camera.limit_bottom = static_body_bottom.global_position.y
		camera.limit_left = static_body_left.global_position.x
		camera.limit_right = static_body_right.global_position.x
		#camera.zoom = zoomV2
	var tween := create_tween()
	tween.tween_property(camera, ("zoom"), Vector2(Zoom, Zoom), 1)
	tween.play()
	await tween.finished
	tween.stop()

		#GlobalNode.SceneFade = true

##	if camera.limit_top != static_body_top.global_position.y and camera.limit_bottom != static_body_bottom.global_position.y and camera.limit_left != static_body_left.global_position.x and camera.limit_right != static_body_right.global_position.x:
##		camera.limit_top += static_body_top.global_position.y/100
##		camera.limit_bottom += static_body_bottom.global_position.y/100
##		camera.limit_left += static_body_left.global_position.x/100
##		camera.limit_right += static_body_right.global_position.x/100
##		camera.zoom = zoomV2/1.5
