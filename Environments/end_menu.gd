extends Control

var main_scene = preload("res://Environments/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display():
	visible = true

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
