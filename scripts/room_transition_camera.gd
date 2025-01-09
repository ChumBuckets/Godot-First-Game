extends Camera2D

const HORIZONTAL_OFFSET : int = 56
const VERTICAL_OFFSET : int = 64

@onready var m_CameraHorizontalMovement : int = get_viewport_rect().size.x - HORIZONTAL_OFFSET
@onready var m_CameraVerticalMovement : int = get_viewport_rect().size.y - VERTICAL_OFFSET
@onready var player: CharacterBody2D = $"../../Player"



var m_CurrentRoom : Vector2 = Vector2.ZERO


var m_OriginOffset : Vector2 = Vector2.ZERO

func _ready():
	m_OriginOffset = player.position
	set_position(m_OriginOffset)

func _UpdateCameraPosition(direction : Vector2) -> void:
	m_CurrentRoom += direction
	set_position(m_OriginOffset + m_CurrentRoom * Vector2(m_CameraHorizontalMovement, m_CameraVerticalMovement))


func _on_area_top_body_entered(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.UP)


func _on_area_bottom_body_entered(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.DOWN)


func _on_area_left_body_entered(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.LEFT)


func _on_area_right_body_entered(body: Node2D) -> void:
	_UpdateCameraPosition(Vector2.RIGHT)
