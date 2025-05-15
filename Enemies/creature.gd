extends CharacterBody2D

@export var speed: float = 300.0
@export var acceleration: float = 200.0
@export var drag: float = 100.0

@onready var player = get_parent().get_node("Player")

var fleeing = false  # Is the creature currently fleeing
var light_timer := 0.0  # Time to continue fleeing
var flee_duration := 2.0  # How long to flee when exposed to light (seconds)

func _physics_process(delta: float) -> void:
	if player == null:
		return

	# Decrease flee timer if active
	#if fleeing:
		#light_timer -= delta
		#if light_timer <= 0:
			#fleeing = false  # Resume chasing

	# Calculate direction
	var player_position = player.global_position
	var direction: Vector2

	if fleeing:
		# Move opposite to the player
		direction = (global_position - player_position).normalized()
	else:
		# Move toward the player
		direction = (player_position - global_position).normalized()

	# Accelerate and move
	if global_position.distance_to(player_position) > 5:
		velocity += direction * acceleration * delta
		if velocity.length() > speed:
			velocity = velocity.normalized() * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)
	
	move_and_slide()
	look_at(player_position)  # Optional: creature always looks at player

func entered_zone(body: CharacterBody2D) -> void:
	if body == player:
		fleeing = true
		#light_timer = flee_duration
		
func exited_zone(body: CharacterBody2D) -> void:
	if body == player:
		fleeing = false
		#light_timer = flee_duration
