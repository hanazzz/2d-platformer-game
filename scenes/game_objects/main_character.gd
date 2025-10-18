extends CharacterBody2D


const SPEED = 320.0
const JUMP_VELOCITY = -900.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
var jump_count = 0


func _physics_process(delta: float) -> void:
	# Animations
	if (velocity.x > 1 || velocity.x < -1):
		sprite_2d.animation = "running"
	else:
		sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite_2d.animation = "jumping"
		
	# Reset jump count when player on floor
	if is_on_floor():
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("jump") and jump_count < 2:
		velocity.y = JUMP_VELOCITY
		jump_count += 1

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
	
	# Force character to jump/bounce away at a diagonal
func jump_side(x):
	# Send character veolcity upwards
	velocity.y = JUMP_VELOCITY
	velocity.x = x
