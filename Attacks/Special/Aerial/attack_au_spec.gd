extends USpecAttack

func boost() -> void:
    p.velocity.y = -1000.0
    p.velocity.x = -200.0 * dir_mult()
