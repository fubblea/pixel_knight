extends Area2D


func _on_body_entered(body: Node2D) -> void:
    print("Coin collected by: ", body.name)
    queue_free() # Remove the coin from the scene when collected
