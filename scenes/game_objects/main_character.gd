extends CharacterBody2D


const SPEED = 320.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@export var particle = preload("res://scenes/game_objects/particle.tscn")
var jump_count = 0

enum States {IDLE, RUNNING, JUMPING, DOUBLE_JUMPING, FALLING, HIT}

var current_state: States = States.IDLE


func _physics_process(delta: float) -> void:
	# Handle physics logic
	# Add the gravity when jumping or falling
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Reset jump count when player on floor
	elif is_on_floor():
		jump_count = 0
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1
		# Add particle animation on double jump
		if (jump_count == 2):
			spawn_particle()
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 14)
	
	# Move player based on velocity
	move_and_slide()
	
	# Handle animations
	if current_state == States.HIT:
		# Finish playing hit animation before returning to default animation
		sprite_2d.play("hit")
		await sprite_2d.animation_finished
		sprite_2d.play("default")
	elif current_state == States.IDLE:
		sprite_2d.play("default")
	elif current_state == States.RUNNING:
		sprite_2d.play("running")
	elif current_state == States.JUMPING:
		sprite_2d.play("jumping")
	elif current_state == States.DOUBLE_JUMPING:
		sprite_2d.play("double_jumping")
	elif current_state == States.FALLING:
		sprite_2d.play("falling")
	
	# If player is moving left, flip sprite to face left
	var isLeft = velocity.x < 0
	sprite_2d.flip_h = isLeft
	
	# Set basic state definitions
	if is_on_floor():
		# If moving left/right on the floor --> running
		if (velocity.x > 1 || velocity.x < -1):
			set_state(States.RUNNING)
		# If not moving on the floor --> idle
		else:
			set_state(States.IDLE)
	elif not is_on_floor():
		# If in the air and moving down --> falling
		if velocity.y > 0:
			set_state(States.FALLING)
		# If jump_count is 1 --> jumping
		elif jump_count == 1:
			set_state(States.JUMPING)
		# Otherwise --> falling
		else:
			set_state(States.DOUBLE_JUMPING)


# Force character to jump/bounce up
func bounce_up():
	# Send character velocity upwards
	velocity.y = JUMP_VELOCITY
	spawn_particle()


# Force character to jump/bounce away to the side
func bounce_side(x):
	# Send character velocity upwards
	velocity.y = JUMP_VELOCITY
	velocity.x = x


# Create particle animation on player
func spawn_particle():
	# Create particle node
	var particle_node = particle.instantiate()
	# Set node position to player's position
	particle_node.position = position
	# Assign particle node to parent node
	get_parent().add_child(particle_node)
	# Wait 0.3 seconds after spawning particle, then destroy particle node
	await get_tree().create_timer(0.3).timeout
	particle_node.queue_free()


# Set current player state
func set_state(new_state: States):
	current_state = new_state
