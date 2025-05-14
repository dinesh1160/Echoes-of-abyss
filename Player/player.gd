extends CharacterBody2D

var speed := 300.0
var acceleration := 800.0  
var drag := 400.0          

@onready var Creature = get_parent().get_node("Creature")

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")

	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		velocity = velocity.move_toward(input_dir * speed, acceleration * delta)
		
		rotation = velocity.angle()
		global_rotation = rotation   # or -90, test both

	else:
		
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	move_and_slide()


func _on_lightarea_body_entered(body: Node2D) -> void:
	if body == Creature:
		#logic of moving away from the submarine(player) which is from the creature (func entered_zone)
		print("detected")
		Creature.entered_zone(self)
		
