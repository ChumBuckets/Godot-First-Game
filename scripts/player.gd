extends CharacterBody2D


var jump_hold_time = 0.4
var air_control = true
var coyote_time = 0.2
var player_looking = 1
var looking = 1
var direction := 0
var friction = 4
var max_speed = 120
var acceleration = 30
var WallJumping = false
const SPEED = 130.0
var JUMP_VELOCITY = -215.0
var checkpoint_position: Vector2
var kinda_looking
var AirJump = false


@onready var turn_timer: Timer = $TurnTimer
@onready var turn_timer_2: Timer = $TurnTimer2
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var internal_ray_cast_3: RayCast2D = $InternalRayCast3
@onready var internal_ray_cast_4: RayCast2D = $InternalRayCast4
@onready var internal_ray_cast: RayCast2D = $InternalRayCast
@onready var internal_ray_cast_2: RayCast2D = $InternalRayCast2
@onready var wall_cast_right: RayCast2D = $WallCastRight
@onready var wall_cast_left: RayCast2D = $WallCastLeft
@export var wall_jump_force = Vector2(300, -500)
@onready var air_area: Area2D = $AirArea

##@onready var slide_cast: RayCast2D = $SlideCast

func _ready():
	checkpoint_position = position  # Initial spawn position


func respawn():
	global_position = checkpoint_position
	velocity.y = 0







func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	##elif slide_cast.is_colliding() and not is_on_floor() and get_gravity() > velocity and WallJumping == false:
		##velocity = velocity * delta
	

	# Handle jump.
	 
	if Input.is_action_pressed("Jump") and jump_hold_time > 0 and (is_on_floor() or coyote_time > 0 or AirJump == true):
		velocity.y = JUMP_VELOCITY 
		jump_hold_time -= delta
	if Input.is_action_just_released("Jump"):
		jump_hold_time = 0.0
	if is_on_floor():
		jump_hold_time = 0.4
		JUMP_VELOCITY = -215.0
		AirJump = false
	
	
	if not is_on_floor():
		coyote_time -= delta
	elif is_on_floor():
		coyote_time = 0.1
	
	
	# Get input direction: -1, 0, 1
	if WallJumping == false:
		direction = Input.get_axis("MoveLeft", "MoveRight")
		if direction != 0:
			player_looking = direction
			looking = direction
	
	##if velocity.x < 0:
		##var direction = 1
	##elif velocity.x > 0:
		##var direction = 1
	
	if is_on_floor() or wall_cast_right.is_colliding() or wall_cast_left.is_colliding():
		WallJumping = false
	
	
	# Flip the sprite
	if WallJumping == false:
		if player_looking > 0:
			animated_sprite.flip_h = false
			player_looking = 1

			

			##slide_cast.global_rotation = 270
		elif player_looking < 0:
			animated_sprite.flip_h = true
			player_looking = -1

			##slide_cast.global_rotation = 90

	
	
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	
	if WallJumping == true:
		air_control = false
	if is_on_floor():
		air_control = true
	
	# Move
	if is_on_floor() and WallJumping == false and direction:
		velocity.x += acceleration * direction 
	elif not is_on_floor() and WallJumping == false and air_control == true and direction != 0:
		velocity.x = move_toward(velocity.x, max_speed * direction, acceleration * 0.9)
	elif not is_on_floor() and WallJumping == false and air_control == true and direction == 0:
		velocity.x = move_toward(velocity.x, 0, acceleration * 0.15)
	elif not is_on_floor() and WallJumping == false and direction:
		velocity.x = move_toward(velocity.x, max_speed * direction, acceleration * 0.5)
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	
	if velocity.x > max_speed:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	elif velocity.x < -max_speed:
		velocity.x = move_toward(velocity.x, 0, acceleration)
	# Apply air friction when not on the ground
	#if not is_on_floor():
		#velocity.x *= AirFriction





	# Detect if near a wall
	if Input.is_action_just_pressed("Jump") and (wall_cast_right.is_colliding() or wall_cast_left.is_colliding()) and not is_on_floor():
		WallJumping = true
		$WallJump.start()
		#looking = -looking
		# Check reverse the current velocity
		
		
		#if looking > 0 and wall_cast_right.is_colliding():
			#velocity.x = -wall_jump_force.x
		#elif looking < 0 and wall_cast_left.is_colliding():
			#velocity.x =  wall_jump_force.x
		
		
		# Apply the vertical wall jump force
		velocity.y = wall_jump_force.y
		
		
		if wall_cast_right.is_colliding():
			looking = -1
			animated_sprite.flip_h = true
			velocity.x = -wall_jump_force.x
			player_looking = -1
			
			##slide_cast.global_rotation = 270
		elif wall_cast_left.is_colliding():
			looking = 1
			animated_sprite.flip_h = false
			velocity.x =  wall_jump_force.x
			player_looking = 1
			
			##slide_cast.global_rotation = 90
		
	
	
	
	# Turns off collision to stop the player from getting stuck
	
	if internal_ray_cast.is_colliding() or internal_ray_cast_2.is_colliding() or internal_ray_cast_3.is_colliding() or internal_ray_cast_4.is_colliding():
		$Timer.start()
		animation_player.play("CollisionOff")
		

	move_and_slide()


#func _on_internal_collission_body_entered(body: Node2D) -> void:
	#$Timer.start()
	#animation_player.play("CollisionOff")
	#print("time")

# Turn collision back on
func _on_timer_timeout() -> void:
	animation_player.play("RESET")

func _on_wall_jump_timeout() -> void:
	WallJumping = false


func _on_kill_detect_body_entered(body: Node2D) -> void:
	respawn()
	

func checkpoint(pos):
	checkpoint_position = pos


func _on_air_area_body_entered(body: Node2D) -> void:
	AirJump = true
	jump_hold_time = 0.9
	JUMP_VELOCITY = -265.0
	
func _on_air_area_body_exited(body: Node2D) -> void:
	jump_hold_time = 0.0
	
	
	


func _on_checkpoint_checkpoint_reached(position: Vector2) -> void:
	checkpoint(position)

func _on_checkpoint_2_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_3_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_4_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_5_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_6_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_7_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_8_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_9_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_10_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_11_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_12_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_13_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_14_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_15_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_16_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)


func _on_checkpoint_17_checkpoint_reached(position: Variant) -> void:
	checkpoint(position)
