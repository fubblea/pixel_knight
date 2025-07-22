extends Area2D

@onready var timer = get_node("Timer")

func _on_body_entered(body: Node2D) -> void:
    print("Body entered killzone: ", body.name)

    timer.start() # Start restart timer

# When the kill timer times out, this function will be called
func _on_timer_timeout() -> void:
    get_tree().reload_current_scene() # Reload the current scene
