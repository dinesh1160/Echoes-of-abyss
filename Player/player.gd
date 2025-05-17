extends CharacterBody2D

var speed := 300.0
var acceleration := 800.0  
var drag := 400.0          

@onready var Creature = get_parent().get_node("Creature")
@onready var Camera = get_parent().get_node("Camera2D")
@onready var End_menu = get_parent().get_node("CanvasLayer/EndMenu")

@onready var sprite: Sprite2D = $Sub
var min_zoom: float = 0.35
var max_zoom: float = 0.85
var zoom_speed: float = 2.0
var zoom_lerp_speed: float = 0.5
var game_over_zoom = Vector2(1.5,1.5)

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")

	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		velocity = velocity.move_toward(input_dir * speed, acceleration * delta)
		#print(input_dir)
		rotation = velocity.angle()
		global_rotation = rotation 
		
		if velocity.x < -10:
			#sprite.flip_h = true
			sprite.flip_v = true
		elif velocity.x > 10:
			#sprite.flip_h = false
			sprite.flip_v = false

	else:
		
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	move_and_slide()
	var current_speed = velocity.length()
	var normalized_speed = clamp(current_speed / speed, 0.0, 1.0)
	var target_zoom_value = lerp(max_zoom, min_zoom, normalized_speed)
	var target_zoom = Vector2(target_zoom_value, target_zoom_value)

	# Interpolate zoom smoothly
	Camera.zoom = Camera.zoom.lerp(target_zoom, zoom_lerp_speed * delta)


func _on_lightarea_body_entered(body: Node2D) -> void:
	if body == Creature:
		Creature.entered_zone(self)
		
func _on_lightarea_body_exited(body: Node2D) -> void:
	if body == Creature:
		Creature.exited_zone(self)


func _on_haltarea_body_entered(body: Node2D) -> void:
	if body == Creature:
		Creature.enter_halt_zone(self)


func _on_haltarea_body_exited(body: Node2D) -> void:
	if body == Creature:
		Creature.exit_halt_zone(self)

func _on_hit_area_body_entered(body: Node2D) -> void:
	if body == Creature:
		game_over_by_attack()
		
func game_over_by_attack() -> void:
	Camera.zoom = Camera.zoom.lerp(game_over_zoom,1)
	Camera.apply_shake()
	await get_tree().create_timer(1).timeout
	Camera.apply_shake()
	End_menu.display()
	get_tree().paused = true
	
	
	
