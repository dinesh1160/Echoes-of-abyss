extends Node2D
@onready var player: CharacterBody2D = $Player
@onready var camera_2d: Camera2D = $Camera2D
@onready var o_2_progress_bar: ProgressBar = $CanvasLayer/O2ProgressBar

@export var total_gameplay_time: float = 120.0 
var elapsed_time: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	o_2_progress_bar.max_value = total_gameplay_time
	o_2_progress_bar.value = total_gameplay_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camera_2d.position = player.position
	elapsed_time += delta
	
	var remaining_time = max(total_gameplay_time - elapsed_time, 0)
	o_2_progress_bar.value = remaining_time
	
	if remaining_time <= 0:
		_game_over()
	
func _game_over():
	print("Oxygen depleted! Game Over.")
