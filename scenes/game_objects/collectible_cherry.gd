extends Area2D

@onready var game_manager: Node = %GameManager

# Called when main character touches cherry. Increases points.
func _on_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
#		Removes cherry node
		queue_free()
#		Calls add_points() to increase points counter
		game_manager.add_points()
