extends CharacterBody2D

var speed := 300.0
var acceleration := 800.0  
var drag := 400.0          


func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")

	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		velocity = velocity.move_toward(input_dir * speed, acceleration * delta)
	else:
		
		velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	move_and_slide()
