extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().paused = false
		visible = false
