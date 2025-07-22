extends Area2D


@onready var timer = get_node("Timer")

func _on_body_entered(body: Node2D) -> void:
    print("Body entered killzone: ", body.name)
    body.die()

    Engine.time_scale = 0.5 # Slow down the game when dying

    timer.start() # Start restart timer

# When the kill timer times out, this function will be called
func _on_timer_timeout() -> void:
    Engine.time_scale = 1.0 # Reset time scale
    get_tree().reload_current_scene() # Reload the current scene
