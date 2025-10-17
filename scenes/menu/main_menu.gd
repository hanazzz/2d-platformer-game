extends Node

@onready var goodbye_panel: Panel = %GoodbyePanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Called when Level1 button is pressed and loads level 1
func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level1.tscn")

# Called when Level2 button is pressed and loads level 2
func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level2.tscn")

# Called when Exit button is pressed. Shows goodbye screen and quits the game
func _on_exit_pressed() -> void:
	goodbye_panel.show()
	get_tree().quit()
