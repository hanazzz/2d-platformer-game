extends CharacterBody2D


const SPEED = 320.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var particle = preload("res://scenes/game_objects/particle.tscn")
var jump_count = 0


func _physics_process(delta: float) -> void:
	# Behavior when character is on floor
	if is_on_floor():
		# Reset jump count when player on floor
		jump_count = 0
		
		# Animations on floor
		if (velocity.x > 1 || velocity.x < -1):
			sprite_2d.animation = "running"
		else:
			sprite_2d.animation = "default"
	
	# Behavior when character is jumping/falling
	else:
		# Add the gravity when jumping or falling
		velocity += get_gravity() * delta
		
		# Fall animation
		if velocity.y > 0:
			sprite_2d.animation = "falling"
		# Jump animation
		elif jump_count == 1:
			sprite_2d.animation = "jumping"
		# Double jump animation
		else:
			sprite_2d.animation = "double_jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		# Add particle animation on double jump
		if (jump_count == 2):
			spawn_particle()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 14)

	move_and_slide()
	
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft

# Force character to jump/bounce up
func jump():
	# Send character veolcity upwards
	velocity.y = JUMP_VELOCITY
	spawn_particle()
	
# Force character to jump/bounce away at a diagonal
func jump_side(x):
	# Send character veolcity upwards
	velocity.y = JUMP_VELOCITY
	velocity.x = x
	
# Create particle animation on player
func spawn_particle():
	# Create particle node
	var particle_node = particle.instantiate()
	# Set node position to player's position
	particle_node.position = position
	# Assign parent node of particle node
	get_parent().add_child(particle_node)
	# Wait 0.3 seconds after spawning particle, then destroy particle node
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()
