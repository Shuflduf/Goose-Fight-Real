extends CharacterBody2D


func _physics_process(delta: float) -> void:
    var input_dir: float = Input.get_axis("ui_left", "ui_right")
    velocity.x = lerp(velocity.x, input_dir * 200.0, delta * 30.0)

    move_and_slide()
