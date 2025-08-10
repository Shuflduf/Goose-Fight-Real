extends Area2D


func _on_body_entered(body: Node2D) -> void:
    print(body)
    body.global_position = global_position
    body.velocity = Vector2.ZERO
