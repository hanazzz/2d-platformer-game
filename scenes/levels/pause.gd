extends Node

@onready var pause_menu: Panel = %PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Check if pause button pressed
	var pause_pressed = Input.is_action_just_pressed("pause")
	# If pressed, then show pause game and show pause menu
	if pause_pressed == true:
		get_tree().paused = true
		pause_menu.show()


# When player clicks resume, hide pause menu and resume game
func _on_resume_pressed() -> void:
	pause_menu.hide()
	get_tree().paused = false


func _on_exit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
