extends RigidBody2D

@onready var game_manager: Node = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Called when player touches enemy
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "CharacterBody2D"):
		# Check for relative position of enemy and player
		var y_delta = position.y - body.position.y
		var x_delta = body.position.x - position.x
		# If player touches enemy from above, destroy enemy
		if y_delta > 30:
			# Remove enemy node
			queue_free()
			# Make player bounce
			body.jump()
		# If player touches enemy from anywhere else, 
		# player takes damage amd gets flung away
		else:
			# Decrease player health
			game_manager.decrease_health()
			# Make player bounce away
			if x_delta > 0:
				body.jump_side(500)
			else:
				body.jump_side(-500)
