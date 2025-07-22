extends CharacterBody2D

@export var SPEED: float = 100.0
@export var JUMP_VELOCITY: float = -300.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var is_dying: bool = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta # Gets the gravity vector from the project settings.

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if is_dying:
		velocity.x = 0 # Stop horizontal movement

	move_and_slide()

func die() -> void:
	is_dying = true # Set dying state to true
	animated_sprite_2d.play("death")
	# Optionally, you can also emit a signal or handle other game logic here.
	print("Player has died.")
