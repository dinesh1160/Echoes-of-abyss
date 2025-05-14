extends CharacterBody2D

@export var speed: float = 300.0
@export var acceleration: float = 200.0
@export var drag: float = 100.0  # Resistance to stop quickly (simulates water)


var player_position: Vector2
var direction_to_player: Vector2

@onready var player = get_parent().get_node("Player")

func _physics_process(delta: float) -> void:
	if player == null:
		return

	player_position = player.global_position
	direction_to_player = (player_position - global_position).normalized() #direction vector

	#only accelerate if far enough from player
	if global_position.distance_to(player_position) > 3:
		#accelerate toward the player
		velocity += direction_to_player * acceleration * delta
		if velocity.length() > speed: #cap the speed
			velocity = velocity.normalized() * speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta) #slow down when close
	move_and_slide()
	look_at(player_position)
	
func entered_zone(body :CharacterBody2D):
	if body == player:
		print("player detected by the creature")
		self.hide()
