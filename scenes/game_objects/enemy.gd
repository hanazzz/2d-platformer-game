extends RigidBody2D

@onready var game_manager: Node = %GameManager
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

#enum States {IDLE, HIT}
#var state : States = States.IDLE

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
		# TODO: Separate enemy taking damage and player taking damage into separate functions?
		# If player touches enemy from above, destroy enemy
		if y_delta > 30:
			# Play hit animation
			animated_sprite_2d.animation = "hit"
			# Make player bounce
			body.jump()
			# Wait until animation finishes before removing node
			await animated_sprite_2d.animation_finished
			queue_free()
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
