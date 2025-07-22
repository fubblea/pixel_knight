extends CharacterBody2D

@export var SPEED: float = 75.0
@export var JUMP_VELOCITY: float = -275.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_dying: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta # Gets the gravity vector from the project settings.

	if is_dying:
		velocity.x = 0 # Stop horizontal movement
		move_and_slide()
		return

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get direction that can be -1, 0, 1.
	var direction := Input.get_axis("move_left", "move_right")

	# Update the sprite animation based on the direction.
	if direction < 0:
		animated_sprite_2d.flip_h = true
	elif direction > 0:
		animated_sprite_2d.flip_h = false

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Play animations
	if is_on_floor() and not is_dying:
		if direction != 0:
			animated_sprite_2d.play("run")
		elif direction == 0:
			animated_sprite_2d.play("idle")
	elif not is_on_floor() and not is_dying:
		animated_sprite_2d.play("jump")

	move_and_slide()

func die() -> void:
	is_dying = true # Set dying state to true
	animated_sprite_2d.play("death")
	# Optionally, you can also emit a signal or handle other game logic here.
	print("Player has died.")
