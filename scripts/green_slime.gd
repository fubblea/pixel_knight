extends Node2D

@export var SPEED: float = 20.0

var direction: Vector2 = Vector2.RIGHT

# Raycasts for platform detection
@onready var raycast_right_down: RayCast2D = $RayCastRightDown
@onready var raycast_left_down: RayCast2D = $RayCastLeftDown
@onready var raycast_right_side: RayCast2D = $RayCastRightSide
@onready var raycast_left_side: RayCast2D = $RayCastLeftSide

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
    # Check right raycasts
    var hit_right = (not raycast_right_down.is_colliding()) or raycast_right_side.is_colliding()

    # Check left raycasts
    var hit_left = (not raycast_left_down.is_colliding()) or raycast_left_side.is_colliding()

    if hit_right:
        direction = Vector2.LEFT
        animated_sprite_2d.flip_h = true
    elif hit_left:
        direction = Vector2.RIGHT
        animated_sprite_2d.flip_h = false

    position += direction * SPEED * delta
