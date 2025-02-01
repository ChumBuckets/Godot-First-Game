
extends CanvasLayer


@export var PPcamera: Camera2D
@export var MainCamera: Camera2D 
@onready var SubView: SubViewport = $SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	var PixelPerfectStuff: Array = get_tree().get_nodes_in_group("PP")
	for thing in PixelPerfectStuff:
		thing.call_deferred("reparent", SubView, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !PPcamera or !MainCamera: return
	PPcamera.set_global_transform(MainCamera.get_global_transform())
	
	PPcamera.limit_bottom = MainCamera.limit_bottom
	PPcamera.limit_top = MainCamera.limit_top
	PPcamera.limit_left = MainCamera.limit_left
	PPcamera.limit_right = MainCamera.limit_right
	PPcamera.scale = MainCamera.scale
