extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 120.0
const JUMP_VELOCITY = -300.0

const MAX_JUMPS: int = 3

var jump_count: int = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and jump_count < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		animated_sprite_2d.play("jump")
		jump_count += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	elif is_on_floor():
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if velocity.x > 0:
		animated_sprite_2d.flip_h = false
	elif velocity.x < 0:
		animated_sprite_2d.flip_h = true

	if is_on_floor() and abs(velocity.x) > 0:
		animated_sprite_2d.play("walk")
	elif is_on_floor():
		animated_sprite_2d.play("default")

	move_and_slide()
