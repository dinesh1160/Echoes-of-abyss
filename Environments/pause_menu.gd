extends Control

func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	read_input()

func read_input():
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused:
			resume()
		else:
			pause()
	
func resume():
	get_tree().paused = false
	visible = false
	
func pause():
	get_tree().paused = true
	visible = true


func _on_resume_pressed() -> void:
	resume() 


func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	get_tree().quit()
