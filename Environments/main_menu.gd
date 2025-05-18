extends Control

var level_scene = preload("res://Environments/level_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_background()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_packed(level_scene)
