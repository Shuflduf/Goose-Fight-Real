extends Projectile

func _physics_process(delta: float) -> void:
    velocity.y += get_gravity().y * delta

    move_and_slide()
