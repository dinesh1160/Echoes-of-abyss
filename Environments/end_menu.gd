extends Control
@onready var label: Label = $Label

var main_scene = preload("res://Environments/main_menu.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func display():
	label.text = "You were a Feast to him! Game Over." 
	visible = true

func display1():
	label.text = "Oxygen depleted! Game Over."  
	visible = true

func completed():
	label.text = "Congrats!!! You Escaped!!"
	visible = true
	get_tree().paused = true
	
func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)
