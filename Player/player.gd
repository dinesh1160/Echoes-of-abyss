extends CharacterBody2D

var speed := 300.0
var acceleration := 800.0  
var drag := 400.0          

@onready var Creature = get_parent().get_node("Creature")
@onready var sprite: Sprite2D = $Sub

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
