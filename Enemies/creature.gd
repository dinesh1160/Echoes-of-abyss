extends CharacterBody2D

@export var speed: float = 100.0
@export var acceleration: float = 200.0
@export var drag: float = 100.0  # Resistance to stop quickly (simulates water)

var player_position: Vector2
var direction_to_player: Vector2

@onready var player = get_parent().get_node("Player")

func _physics_process(delta: float) -> void:
	if player == null:
		return

	# Get player position
	player_position = player.global_position

	# Direction vector towards the player
	direction_to_player = (player_position - global_position).normalized()

	# Only accelerate if far enough from player
	if global_position.distance_to(player_position) > 3:
		# Accelerate toward the player
		velocity += direction_to_player * acceleration * delta
		# Cap the speed
		if velocity.length() > speed:
			velocity = velocity.normalized() * speed
	else:
		# Slow down when close to player
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	# Apply movement
	move_and_slide()

	# Face the player
	look_at(player_position)
