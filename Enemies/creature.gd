extends CharacterBody2D

@export var speed: float = 500.0
@export var acceleration: float = 200.0
@export var drag: float = 50.0

@onready var player = get_parent().get_node("Player")
@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var fleeing = false
var halt = false
var nav_ready = false

func _ready() -> void:
	agent.path_desired_distance = 10.0
	agent.target_desired_distance = 5.0
	await get_tree().process_frame  
	nav_ready = true

func _physics_process(delta: float) -> void:

	if player == null or not nav_ready:
		return

	if fleeing:
		# Move away from player directly, ignore pathfinding
		animated_sprite_2d.play("idle")
		var flee_direction = (global_position - player.global_position).normalized()
		velocity = flee_direction * speed*0.3
	elif halt and !fleeing:
		animated_sprite_2d.play("idle")
		velocity = Vector2.ZERO
		
	else:
		
		animated_sprite_2d.play("chase")
		agent.set_target_position(player.global_position)

		if agent.is_navigation_finished():
			velocity = velocity.move_toward(Vector2.ZERO, drag * delta)
		else:
			var next_position = agent.get_next_path_position()
			var direction = (next_position - global_position).normalized()
			velocity = velocity.move_toward(direction * speed, acceleration * delta)

	move_and_slide()
	look_at(player.global_position)

func entered_zone(body: CharacterBody2D) -> void:
	if body == player:
		fleeing = true

func exited_zone(body: CharacterBody2D) -> void:
	if body == player:
		fleeing = false
		
func enter_halt_zone(body: CharacterBody2D) -> void:
	if body == player:
		halt = true
	
func exit_halt_zone(body: CharacterBody2D) -> void:
	if body == player:
		halt = false
