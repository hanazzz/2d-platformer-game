extends RigidBody2D

@onready var game_manager: Node = %GameManager
# Enemy sprite
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	# Check if player touched enemy
	if (body.name == "CharacterBody2D"):
		var player = body
		# Check for relative position of enemy and player
		var y_delta = position.y - player.position.y
		var x_delta = player.position.x - position.x
		# TODO: Refactor code here.
		# Maybe: Put enemy taking damage and player taking damage into dedicated functions?
		# e.g. take_damage() function defined in script for each object
		# If player touches enemy from above, destroy enemy
		if y_delta > 30:
			# Play hit animation
			animated_sprite_2d.animation = "hit"
			# Make player bounce
			player.bounce_up()
			# Wait until animation finishes before removing node
			await animated_sprite_2d.animation_finished
			queue_free()
		# If player touches enemy from anywhere else, 
		# player takes damage amd gets flung away
		else:
			# Decrease player health
			game_manager.decrease_health()
			# Change player state to HIT
			player.set_state(5)
			# Make player bounce away
			if x_delta > 0:
				player.bounce_side(500)
			else:
				player.bounce_side(-500)
